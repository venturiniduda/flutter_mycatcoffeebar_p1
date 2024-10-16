import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

final DadosService srv = GetIt.instance<DadosService>();

class SenhaView extends StatefulWidget {
  SenhaView({super.key});

  // Para a mensagem na barra
  final msgKey = GlobalKey<ScaffoldMessengerState>();

  @override
  State<SenhaView> createState() => _SenhaViewState();
}

class _SenhaViewState extends State<SenhaView> {
  final GlobalKey<FormState> passwordKey = GlobalKey<FormState>();
  var txtSenhaNew = TextEditingController();
  var txtSenhaRpt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String email = ModalRoute.of(context)!.settings.arguments as String;

    return ScaffoldMessenger(
      key: widget.msgKey,
      child: Scaffold(
        body: Center(
          child: Form(
            key: passwordKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    height: 150,
                    width: 200,
                  ),
                  Text(
                    'redefina sua senha',
                    style: GoogleFonts.reenieBeanie(fontSize: 45),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtSenhaNew,
                    decoration: InputDecoration(
                      labelText: 'Digite sua nova senha',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Insira sua nova senha:',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: txtSenhaRpt,
                    decoration: InputDecoration(
                      labelText: 'Repita sua nova senha',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Repita sua nova senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'login',
                            (Route<dynamic> route) => false,
                          );
                        },
                        icon: const Icon(Icons.cancel, size: 50.0),
                        color: Colors.red,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      IconButton(
                        onPressed: () {
                          if (txtSenhaNew.text != txtSenhaRpt.text) {
                            widget.msgKey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text('As senhas não coincidem!'),
                                duration: Duration(seconds: 5),
                              ),
                            );
                          } else {
                            // alterando a senha na estrutura global
                            var index = srv.obterIndexPorEmail(email);
                            if (index != null) {
                              srv.users[index].senha = txtSenhaNew.text;
                              widget.msgKey.currentState!.showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'A senha foi alterada com sucesso! Retornando para o Login...'),
                                  duration: Duration(seconds: 10),
                                ),
                              );
                              Timer(Duration(seconds: 2), () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  'login',
                                  (Route<dynamic> route) => false,
                                );
                              });
                            }
                          }
                        },
                        icon: const Icon(Icons.check_circle, size: 50.0),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
