import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

import '../controller/ct_login.dart';

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
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: loginKey,
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/logo.png',
                      height: MediaQuery.of(context).size.height * .35,
                      width: MediaQuery.of(context).size.width * .10,
                    ),
                    Text(
                      'Login',
                      style: GoogleFonts.reenieBeanie(fontSize: 90),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(
                      height: 5,
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
                        validator: (txtConta) {
                          if (txtConta == null) {
                            return 'Informe o Email';
                          } else if (txtConta.isEmpty) {
                            return 'Informe o Email';
                          } else {
                            if (!EmailValidator.validate(txtConta)) {
                              return 'Digite um Email válido!';
                            }
                            return null;
                          }
                        }),
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
                        validator: (txtSenha) {
                          if (txtSenha == null) {
                            return 'Informe a Senha';
                          } else if (txtSenha.isEmpty) {
                            return 'Informe a Senha';
                          }
                          return null;
                        }),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pushNamed(context, 'senha');
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
                          tooltip: 'Cancelar',
                        ),
                        SizedBox(
                          height: 10,
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
                          tooltip: 'Cadastrar Usuário',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        IconButton(
                          onPressed: () {
                            // VERIFICAÇÃO DADOS LOGIN
                            if (loginKey.currentState!.validate()) {
                              LoginController().login(
                                context,
                                txtConta.text,
                                txtSenha.text,
                              );
                            }
                          },
                          icon: const Icon(Icons.check_circle, size: 50.0),
                          color: Colors.green,
                          tooltip: 'Realizar o Login',
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
