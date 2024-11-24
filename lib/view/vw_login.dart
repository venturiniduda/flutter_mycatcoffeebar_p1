import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Dimensões base do design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ScaffoldMessenger(
          key: widget.msgKey,
          child: Scaffold(
            body: Center(
              child: Form(
                key: loginKey,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'lib/images/logo.png',
                        height: 250.h,
                        width: 350.w,
                      ),
                      Text(
                        'Login',
                        style: GoogleFonts.reenieBeanie(fontSize: 30.sp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20.h),
                      TextFormField(
                        controller: txtConta,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                          hintText: 'Insira seu email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        validator: (txtConta) {
                          if (txtConta == null || txtConta.isEmpty) {
                            return 'Informe o Email';
                          } else if (!EmailValidator.validate(txtConta)) {
                            return 'Digite um Email válido!';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15.h),
                      TextFormField(
                        controller: txtSenha,
                        decoration: InputDecoration(
                          labelText: 'Senha',
                          labelStyle:
                              TextStyle(color: Colors.black, fontSize: 16.sp),
                          hintText: 'Insira sua senha',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.r),
                          ),
                        ),
                        validator: (txtSenha) {
                          if (txtSenha == null || txtSenha.isEmpty) {
                            return 'Informe a Senha';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              Navigator.pushNamed(context, 'senha');
                            },
                            icon: Icon(Icons.key_off, size: 15.sp),
                            label: Text(
                              'Esqueci a senha',
                              style: TextStyle(fontSize: 14.sp),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
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
                            icon: const Icon(Icons.cancel),
                            iconSize: 50.sp,
                            color: Colors.red,
                            tooltip: 'Cancelar',
                          ),
                          SizedBox(width: 15.w),
                          IconButton(
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                'cadastro',
                                (Route<dynamic> route) => false,
                              );
                            },
                            icon: const Icon(Icons.add_circle),
                            iconSize: 50.sp,
                            color: Colors.blue,
                            tooltip: 'Cadastrar Usuário',
                          ),
                          SizedBox(width: 15.w),
                          IconButton(
                            onPressed: () {
                              if (loginKey.currentState!.validate()) {
                                LoginController().login(
                                  context,
                                  txtConta.text,
                                  txtSenha.text,
                                );
                              }
                            },
                            icon: const Icon(Icons.check_circle),
                            iconSize: 50.sp,
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
        );
      },
    );
  }
}
