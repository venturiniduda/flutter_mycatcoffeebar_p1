import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:flutter_mycatcoffeebar_p1/view/vw_cadastro.dart';
import 'package:flutter_mycatcoffeebar_p1/view/vw_cardapio.dart';
import 'package:flutter_mycatcoffeebar_p1/view/vw_detailsfood.dart';
import 'package:flutter_mycatcoffeebar_p1/view/vw_home.dart';
import 'package:flutter_mycatcoffeebar_p1/view/vw_login.dart';
import 'package:flutter_mycatcoffeebar_p1/view/vw_senha.dart';
import 'package:get_it/get_it.dart';

// to do geral:
// se tiver tempo, adicionar verificação se email ja foi cadastrado

// Criando a estrutura global
final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<DadosService>(DadosService());
  // getIt.registerLazySingleton<DadosService>(() => DadosService());

  runApp(
    DevicePreview(
      enabled: true,
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
        'detailsfood': (context) => DetailsFoodView(),
      },
      home: Scaffold(
        body: Center(
          child: Text('Hello World! 123'),
        ),
      ),
    );
  }
}
