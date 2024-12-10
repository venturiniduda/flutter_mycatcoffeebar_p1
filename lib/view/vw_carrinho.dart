import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_carrinho.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_carrinho.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final CarrinhoController carrinhoController = CarrinhoController();

class CarrinhoView extends StatefulWidget {
  const CarrinhoView({super.key});

  @override
  State<CarrinhoView> createState() => _CarrinhoViewState();
}

class _CarrinhoViewState extends State<CarrinhoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'RESUMO DO PEDIDO',
          style: GoogleFonts.holtwoodOneSc(fontSize: 20, color: Colors.black),
        ),
        backgroundColor: Colors.brown.shade300,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'cardapio');
            },
            icon: const Icon(Icons.menu_book, size: 25.0),
            color: Colors.black,
            tooltip: 'Abrir Cardápio',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: CarrinhoController().listar(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return Center(
                      child: Text('Não foi possível conectar.'),
                    );
                  case ConnectionState.waiting:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  default:
                  final itemCarrinho = snapshot.requireData;
                    if (itemCarrinho.size > 0) {
                       return Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: itemCarrinho.size,
                          itemBuilder: (context, index) {
                            
                          },
                        ),
                       );
                    }else{

                    }
              },
            ),
          ],
        ),
      ),
    );
  }
}
