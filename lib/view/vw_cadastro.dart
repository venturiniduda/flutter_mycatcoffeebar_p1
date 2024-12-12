import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_login.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

final DadosService srv = GetIt.instance<DadosService>();

class CadastroView extends StatefulWidget {
  CadastroView({super.key});

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
// Variáveis para Login
  final GlobalKey<FormState> cadastroKey = GlobalKey<FormState>();
  var txtNome = TextEditingController();
  var txtSobrenome = TextEditingController();
  var txtCel = TextEditingController();
  var txtConta = TextEditingController();
  var txtSenha = TextEditingController();
  var txtSenhaconf = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Form(
            key: cadastroKey,
            child: Padding(
              padding: EdgeInsets.fromLTRB(30, 50, 30, 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    height: 70,
                    width: 70,
                  ),
                  Text(
                    'Cadastro',
                    style: GoogleFonts.reenieBeanie(fontSize: 70),
                    textAlign: TextAlign.end,
                  ),
                  TextFormField(
                      controller: txtNome,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Insira seu nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (txtNome) {
                        if (txtNome == null) {
                          return 'Informe um Nome';
                        } else if (txtNome.isEmpty) {
                          return 'Informe um Nome';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: txtSobrenome,
                      decoration: InputDecoration(
                        labelText: 'Sobrenome',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Insira seu sobrenome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (txtSobrenome) {
                        if (txtSobrenome == null) {
                          return 'Informe um Sobrenome';
                        } else if (txtSobrenome.isEmpty) {
                          return 'Informe um Sobrenome';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: txtCel,
                      decoration: InputDecoration(
                        labelText: 'Celular',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText:
                            'Digite o número de celular (Ex: 16991234567)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (txtCel) {
                        if (txtCel == null) {
                          return 'Informe um Celular';
                        } else if (txtCel.isEmpty) {
                          return 'Informe um Celular';
                        } else {
                          final regex = RegExp(r'^\d{2}\d{9}$');
                          if (!regex.hasMatch(txtCel)) {
                            return 'Número de celular inválido';
                          }
                          return null;
                        }
                      }),
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
                          )),
                      validator: (txtConta) {
                        if (txtConta == null) {
                          return 'Informe um Email';
                        } else if (txtConta.isEmpty) {
                          return 'Informe um Email';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10,
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
                          return 'Informe um Senha';
                        } else if (txtSenha.isEmpty) {
                          return 'Informe um Senha';
                        }
                        return null;
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                      controller: txtSenhaconf,
                      decoration: InputDecoration(
                        labelText: 'Confirmação de Senha',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Insira sua senha novamente',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (txtSenhaconf) {
                        if (txtSenhaconf == null || txtSenhaconf.isEmpty) {
                          return 'Confirme sua senha';
                        } else if (txtSenhaconf != txtSenha.text) {
                          return 'As senhas estão diferentes!';
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
                          if (cadastroKey.currentState!.validate()) {
                            // salvando dados do usuário e criando conta
                            LoginController().criarConta(
                                context,
                                txtNome.text,
                                txtSobrenome.text,
                                txtCel.text,
                                txtConta.text,
                                txtSenha.text);
                          }
                        },
                        icon: const Icon(Icons.check_circle, size: 50.0),
                        color: Colors.green,
                        tooltip: 'Cadastrar',
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
