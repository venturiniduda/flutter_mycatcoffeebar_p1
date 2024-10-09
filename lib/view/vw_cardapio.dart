import 'package:flutter/material.dart';

// to do: organizar em um ListView e, nos botoes de categoria, quando clicados,
// pular para o indice que corresponde a essa categoria

// botão logout

class CardapioView extends StatefulWidget {
  const CardapioView({super.key});

  @override
  State<CardapioView> createState() => _CardapioViewState();
}

class _CardapioViewState extends State<CardapioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ListView(),
      ),
    );
  }
}
