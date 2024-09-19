import 'package:flutter/material.dart';

class DetailsFoodView extends StatefulWidget {
  const DetailsFoodView({super.key});

  @override
  State<DetailsFoodView> createState() => _DetailsFoodViewState();
}

class _DetailsFoodViewState extends State<DetailsFoodView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Detalhes Comida'),
      ),
    );
  }
}
