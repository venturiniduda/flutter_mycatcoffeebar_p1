import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_cardapio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../service/srv_dados.dart';

// to do: organizar em um ListView e, nos botoes de categoria, quando clicados,
// pular para o indice que corresponde a essa categoria

final DadosService srv = GetIt.instance<DadosService>();

class CardapioView extends StatefulWidget {
  const CardapioView({super.key});

  @override
  State<CardapioView> createState() => _CardapioViewState();
}

class _CardapioViewState extends State<CardapioView> {
  List<String> categorias = [
    'Entradas',
    'Pratos Principais',
    'Sobremesa',
    'Bebidas'
  ];

  int index = 0;

  @override
  void initState() {
    Cardapio.preencher();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MENU',
          style: GoogleFonts.holtwoodOneSc(
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.brown.shade300,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            padding: EdgeInsets.only(right: 30),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'carrinho');
            },
            icon: Icon(Icons.shopping_bag_rounded, color: Colors.black),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                'login',
                (Route<dynamic> route) => false,
              );
            },
            icon: const Icon(Icons.logout_rounded, size: 30.0),
            color: Colors.black,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Wrap(
                spacing: 5.0,
                runSpacing: 8.0,
                children: <Widget>[
                  TextButton.icon(
                    onPressed: () {
                      index = 5;
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown.shade200,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                    icon: const Icon(
                      Icons.coffee,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Entradas',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown.shade200,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                    icon: const Icon(
                      Icons.coffee,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Pratos Principais',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown.shade200,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                    icon: const Icon(
                      Icons.coffee,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Sobremesas',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.brown.shade200,
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 16.0),
                    ),
                    icon: const Icon(
                      Icons.coffee,
                      size: 20.0,
                      color: Colors.black,
                    ),
                    label: Text(
                      'Bebidas',
                      style: TextStyle(fontSize: 16.0, color: Colors.black),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: srv.cardapio.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(srv.cardapio[index].nome,
                          style: TextStyle(fontSize: 22)),
                      subtitle: Text(
                        NumberFormat('#,##0.00')
                            .format(srv.cardapio[index].valor),
                        style: TextStyle(fontSize: 14),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              // adicionar item no carrinho
                            },
                            child: Icon(Icons.add_shopping_cart),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              // abrir detalhes do item
                              Navigator.pushNamed(context, 'detalhes',
                                  arguments: index);
                            },
                            child: Icon(Icons.arrow_right),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
