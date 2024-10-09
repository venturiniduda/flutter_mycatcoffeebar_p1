import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_cadastro.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';

// to-do:
// adicionar verificação de formato email

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
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'lib/images/logo.png',
                    height: 150,
                    width: 250,
                  ),
                  Text(
                    'Cadastro',
                    style: GoogleFonts.reenieBeanie(fontSize: 100),
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
                  ),
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
                  ),
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
                  ),
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
                  ),
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
                  ),
                  SizedBox(
                    height: 15,
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
                          if (txtNome.text != ' ' &&
                              txtSobrenome.text != ' ' &&
                              txtCel.text != ' ' &&
                              txtCep.text != ' ' &&
                              txtConta.text != ' ' &&
                              txtSenha.text != ' ' &&
                              txtSenhaconf.text != ' ') {
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
                          } else {
                            // colocar erro de campos obrigatórios não foram preenchidos
                            widget.msgKey.currentState!.showSnackBar(
                              SnackBar(
                                content: Text('Há campos vazios...'),
                                duration: Duration(seconds: 5),
                              ),
                            );
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
