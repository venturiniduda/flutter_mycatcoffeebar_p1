import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';

import 'service/srv_dados.dart';
import 'view/vw_cadastro.dart';
import 'view/vw_cardapio.dart';
import 'view/vw_carrinho.dart';
import 'view/vw_detailsfood.dart';
import 'view/vw_home.dart';
import 'view/vw_login.dart';
import 'view/vw_senha.dart';

// Criando a estrutura global
final getIt = GetIt.instance;

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  getIt.registerSingleton<DadosService>(DadosService());

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeView(),
        'login': (context) => LoginView(),
        'cadastro': (context) => CadastroView(),
        'senha': (context) => SenhaView(),
        'cardapio': (context) => CardapioView(),
        'detalhes': (context) => DetalhesView(),
        'carrinho': (context) => CarrinhoView(),
      },
      home: Scaffold(
        body: Center(
          child: Text('Hello World! 123'),
        ),
      ),
    );
  }
}
