import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controller/ct_login.dart';

final DadosService srv = GetIt.instance<DadosService>();

class SenhaView extends StatefulWidget {
  SenhaView({super.key});

  // Para a mensagem na barra
  final msgKey = GlobalKey<ScaffoldMessengerState>();

  @override
  State<SenhaView> createState() => _SenhaViewState();
}

class _SenhaViewState extends State<SenhaView> {
  final GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  var txtEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: widget.msgKey,
      child: Scaffold(
        body: Center(
          child: Form(
            key: emailKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
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
                        controller: txtEmail,
                        decoration: InputDecoration(
                          labelText: 'Digite seu email cadastrado',
                          labelStyle: TextStyle(color: Colors.black),
                          hintText: 'Insira seu email cadastrado:',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                        validator: (txtSenhaNew) {
                          if (txtSenhaNew == null) {
                            return 'Informe o email cadastrado';
                          } else if (txtSenhaNew.isEmpty) {
                            return 'Informe o email cadastrado';
                          }
                          return null;
                        }),
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
                          tooltip: 'Cancelar',
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        IconButton(
                          onPressed: () {
                            if (emailKey.currentState!.validate()) {
                              widget.msgKey.currentState!.showSnackBar(
                                SnackBar(
                                    content: Text('As senhas não coincidem!'),
                                    duration: Duration(seconds: 2),
                                    backgroundColor: Colors.black54),
                              );
                              LoginController().esqueceuSenha(
                                context,
                                txtEmail.text,
                              );
                              widget.msgKey.currentState!.showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Email para redefinir sua senha foi enviado com sucesso! Retornando para o Login...'),
                                    duration: Duration(seconds: 10),
                                    backgroundColor: Colors.black54),
                              );
                              Timer(Duration(seconds: 2), () {
                                Navigator.pushNamedAndRemoveUntil(
                                  context,
                                  'login',
                                  (Route<dynamic> route) => false,
                                );
                              });
                            }
                          },
                          icon: const Icon(Icons.check_circle, size: 50.0),
                          color: Colors.green,
                          tooltip: 'Modificar Senha',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
