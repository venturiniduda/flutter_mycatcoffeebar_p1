import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_cardapio.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_carrinho.dart';
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
  final ScrollController _scrollController = ScrollController();

  List<String> categorias = [
    'Entradas',
    'Pratos Principais',
    'Sobremesa',
    'Bebidas'
  ];

  double itemHeight = 105.0;
  String legenda = ' ';

  void _scrollToNextCat(int jump) {
    final newPosition;
    if (_scrollController.hasClients) {
      if (jump == 0) {
        newPosition = 0;
      } else {
        newPosition = jump * itemHeight;
      }
      _scrollController.jumpTo(newPosition);
    }
  }

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
      body: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Column(
          children: [
            Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _scrollToNextCat(0);
                      legenda = 'Entradas';
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                  onPressed: () {
                    setState(() {
                      _scrollToNextCat(10);
                      legenda = 'Pratos Principais';
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                  onPressed: () {
                    setState(() {
                      _scrollToNextCat(18);
                      legenda = 'Sobremesas';
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                  onPressed: () {
                    setState(() {
                      _scrollToNextCat(31);
                      legenda = 'Bebidas';
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                itemCount: srv.cardapio.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: 250,
                    height: itemHeight,
                    child: Card(
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
                                srv.adicionarCarrinho(Carrinho(
                                    srv.cardapio[index].codigo,
                                    srv.cardapio[index].nome,
                                    srv.cardapio[index].categoria,
                                    srv.cardapio[index].valor,
                                    1));
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
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
