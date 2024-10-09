import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

// to do:
// adicionar "legenda" quando passamos o mouse nos botões
// adicionar loop (?) para achar dado correspondente do usuário

final DadosService srv = GetIt.instance<DadosService>();

class LoginView extends StatefulWidget {
  LoginView({super.key});

  // Para a mensagem na barra
  final msgKey = GlobalKey<ScaffoldMessengerState>();

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  // Variáveis para Login
  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  var txtConta = TextEditingController();
  var txtSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: widget.msgKey,
      child: Scaffold(
        body: Center(
          child: Form(
            key: loginKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    height: 250,
                    width: 350,
                  ),
                  Text(
                    'Login',
                    style: GoogleFonts.reenieBeanie(fontSize: 150),
                    textAlign: TextAlign.end,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: txtConta,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Insira seu email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: txtSenha,
                    decoration: InputDecoration(
                      labelText: 'Senha',
                      labelStyle: TextStyle(color: Colors.black),
                      hintText: 'Insira sua senha',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'senha',
                            (Route<dynamic> route) => true,
                          );
                        },
                        style: ButtonStyle(
                          iconSize: WidgetStateProperty.all(15),
                        ),
                        icon: Icon(Icons.key_off),
                        label: Text(
                          'Esqueci a senha',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'home',
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
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            'cadastro',
                            (Route<dynamic> route) => false,
                          );
                        },
                        icon: const Icon(Icons.add_circle, size: 50.0),
                        color: Colors.blue,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      IconButton(
                        onPressed: () {
                          // comparando dados de login
                          if (txtConta.text == ' ' && txtSenha.text == ' ') {
                            widget.msgKey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text('Preencha os campos!'),
                                duration: Duration(seconds: 10),
                              ),
                            );
                          } else {
                            if (srv.users.isNotEmpty &&
                                (srv.users[0].email == txtConta.text) &&
                                (srv.users[0].senha == txtSenha.text)) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                'cardapio',
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              //senha incorreta
                              widget.msgKey.currentState!.showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Login ou senha incorretos. Tente novamente!'),
                                  duration: Duration(seconds: 10),
                                ),
                              );
                              txtConta.text = ' ';
                              txtSenha.text = ' ';
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
