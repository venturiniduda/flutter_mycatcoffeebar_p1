import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_cadastro.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_validator/email_validator.dart';

final DadosService srv = GetIt.instance<DadosService>();

class CadastroView extends StatefulWidget {
  CadastroView({super.key});

  // Para a mensagem na barra
  final msgKey = GlobalKey<ScaffoldMessengerState>();

  @override
  State<CadastroView> createState() => _CadastroViewState();
}

class _CadastroViewState extends State<CadastroView> {
// Variáveis para Login
  final GlobalKey<FormState> cadastroKey = GlobalKey<FormState>();
  var txtNome = TextEditingController();
  var txtSobrenome = TextEditingController();
  var txtCep = TextEditingController();
  var txtCel = TextEditingController();
  var txtConta = TextEditingController();
  var txtSenha = TextEditingController();
  var txtSenhaconf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      child: Scaffold(
        body: Center(
          child: Form(
            key: cadastroKey,
            child: Padding(
              padding: EdgeInsets.all(15.0),
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
                      controller: txtCep,
                      decoration: InputDecoration(
                        labelText: 'CEP',
                        labelStyle: TextStyle(color: Colors.black),
                        hintText: 'Digite seu CEP (formato: 11111-111)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (txtCep) {
                        if (txtCep == null) {
                          return 'Informe um CEP';
                        } else if (txtCep.isEmpty) {
                          return 'Informe um CEP';
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
                        hintText: 'Digite seu número de celular',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                      ),
                      validator: (txtCel) {
                        if (txtCel == null) {
                          return 'Informe um Celular';
                        } else if (txtCel.isEmpty) {
                          return 'Informe um Celular';
                        }
                        return null;
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
                        } else {
                          if (!EmailValidator.validate(txtConta)) {
                            return 'Digite um Email válido!';
                          }
                          return null;
                        }
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
                        if (txtSenhaconf == null) {
                          return 'Confirme sua senha';
                        } else if (txtSenhaconf.isEmpty) {
                          return 'Confirme sua senha';
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
                            if (txtSenha.text == txtSenhaconf.text) {
                              // salvando dados do usuário
                              srv.adicionarUser(CadastroUser(
                                  txtNome.text,
                                  txtSobrenome.text,
                                  txtConta.text,
                                  txtCel.text,
                                  txtSenha.text,
                                  txtCep.text));
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                'login',
                                (Route<dynamic> route) => false,
                              );
                            } else {
                              // colocar erro de senhas não conferem
                              widget.msgKey.currentState!.showSnackBar(
                                SnackBar(
                                  content: Text('Senhas não conferem!'),
                                  duration: Duration(seconds: 5),
                                ),
                              );
                              txtSenhaconf.text = ' ';
                            }
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
