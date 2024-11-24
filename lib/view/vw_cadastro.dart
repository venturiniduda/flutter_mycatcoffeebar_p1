import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
  // Variáveis para Cadastro
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
    return ScreenUtilInit(
      designSize: const Size(360, 690), // Tamanho base do design
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: Form(
              key: cadastroKey,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 50.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'lib/images/logo.png',
                      height: 70.h,
                      width: 70.w,
                    ),
                    Text(
                      'Cadastro',
                      style: GoogleFonts.reenieBeanie(fontSize: 40.sp),
                      textAlign: TextAlign.end,
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: txtNome,
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16.sp),
                        hintText: 'Insira seu nome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      validator: (txtNome) {
                        if (txtNome == null || txtNome.isEmpty) {
                          return 'Informe um Nome';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: txtSobrenome,
                      decoration: InputDecoration(
                        labelText: 'Sobrenome',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16.sp),
                        hintText: 'Insira seu sobrenome',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      validator: (txtSobrenome) {
                        if (txtSobrenome == null || txtSobrenome.isEmpty) {
                          return 'Informe um Sobrenome';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: txtCel,
                      decoration: InputDecoration(
                        labelText: 'Celular',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16.sp),
                        hintText:
                            'Digite o número de celular (Ex: 16991234567)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      validator: (txtCel) {
                        if (txtCel == null || txtCel.isEmpty) {
                          return 'Informe um Celular';
                        } else {
                          final regex = RegExp(r'^\d{2}\d{9}$');
                          if (!regex.hasMatch(txtCel)) {
                            return 'Número de celular inválido';
                          }
                          return null;
                        }
                      },
                    ),
                    SizedBox(height: 10.h),
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
                          return 'Informe um Email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
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
                          return 'Informe uma Senha';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
                    TextFormField(
                      controller: txtSenhaconf,
                      decoration: InputDecoration(
                        labelText: 'Confirmação de Senha',
                        labelStyle:
                            TextStyle(color: Colors.black, fontSize: 16.sp),
                        hintText: 'Insira sua senha novamente',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.r),
                        ),
                      ),
                      validator: (txtSenhaconf) {
                        if (txtSenhaconf == null || txtSenhaconf.isEmpty) {
                          return 'Confirme sua senha';
                        } else if (txtSenhaconf != txtSenha.text) {
                          return 'As senhas estão diferentes!';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10.h),
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
                          icon: const Icon(Icons.cancel),
                          iconSize: 50.sp,
                          color: Colors.red,
                          tooltip: 'Cancelar',
                        ),
                        SizedBox(width: 15.w),
                        IconButton(
                          onPressed: () {
                            if (cadastroKey.currentState!.validate()) {
                              // Salvando dados do usuário e criando conta
                              LoginController().criarConta(
                                context,
                                txtNome.text,
                                txtSobrenome.text,
                                txtCel.text,
                                txtConta.text,
                                txtSenha.text,
                              );
                            }
                          },
                          icon: const Icon(Icons.check_circle),
                          iconSize: 50.sp,
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
        );
      },
    );
  }
}
