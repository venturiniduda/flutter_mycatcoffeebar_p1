import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import '../service/srv_dados.dart';

// to do: organizar em um ListView e, nos botoes de categoria, quando clicados,
// pular para o indice que corresponde a essa categoria

// botão logout -> levar p login

final DadosService srv = GetIt.instance<DadosService>();

class CardapioView extends StatefulWidget {
  const CardapioView({super.key});

  @override
  State<CardapioView> createState() => _CardapioViewState();
}

class _CardapioViewState extends State<CardapioView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cardápio',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple.shade900,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'inserir');
            },
            icon: Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.purple.shade50,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(),
            ListView.builder(
              itemCount: srv.cardapio.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(srv.cardapio[index].nome,
                        style: TextStyle(fontSize: 22)),
                    subtitle: Text(
                      NumberFormat('#,##0.00')
                          .format(srv.cardapio[index].valor),
                      style:
                          TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                    ),
                    trailing: Icon(Icons.arrow_right),
                    onTap: () {
                      Navigator.pushNamed(context, 'detailsfood',
                          arguments: index);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
