import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// to do:
// adicionar "legenda" quando passamos o mouse nos botões
// diminuir tamanho botão esqueceu a senha e alinhar na esquerda

class LoginView extends StatefulWidget {
  const LoginView({super.key});

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
    return Scaffold(
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
                  height: 15,
                ),
                Row(
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.key_off),
                      label: Text('Esqueci a senha'),
                      iconAlignment: IconAlignment.end,
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
                      icon: const Icon(Icons.cancel, size: 30.0),
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
                      icon: const Icon(Icons.add_circle, size: 30.0),
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'cardapio',
                          (Route<dynamic> route) => false,
                        );
                      },
                      icon: const Icon(Icons.check_circle, size: 30.0),
                      color: Colors.green,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
