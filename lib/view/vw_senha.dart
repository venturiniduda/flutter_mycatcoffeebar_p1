import 'package:flutter/material.dart';

class SenhaView extends StatefulWidget {
  const SenhaView({super.key});

  @override
  State<SenhaView> createState() => _SenhaViewState();
}

class _SenhaViewState extends State<SenhaView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Esqueceu a senha'),
      ),
    );
  }
}
