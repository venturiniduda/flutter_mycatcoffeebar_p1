import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_carrinho.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controller/ct_cardapio.dart';
import '../controller/ct_login.dart';
import '../service/srv_dados.dart';

final DadosService srv = GetIt.instance<DadosService>();

class CardapioView extends StatefulWidget {
  const CardapioView({super.key});

  @override
  State<CardapioView> createState() => _CardapioViewState();
}

class _CardapioViewState extends State<CardapioView> {
  final ScrollController _scrollController = ScrollController();
  double itemHeight = 105.0;
  String categoria = '';

  void _scrollToNextCat(int jump) {
    var newPosition;
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
    // srv.preencherListaCardapio();
    // srv.preencherCategorias();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'MENU',
          style: GoogleFonts.holtwoodOneSc(fontSize: 20, color: Colors.black),
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
              srv.carrinho.clear();
              srv.valorTotal = 0;
              LoginController().logout();
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            // BOTÕES CATEGORIA
            Wrap(
              spacing: 5.0,
              runSpacing: 5.0,
              children: <Widget>[
                TextButton.icon(
                  onPressed: () {
                    categoria = 'Entradas';
                    setState(() {
                      _scrollToNextCat(0);
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  ),
                  icon: const Icon(
                    Icons.bakery_dining,
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
                    categoria = 'Pratos Principais';
                    setState(() {
                      _scrollToNextCat(10);
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  ),
                  icon: const Icon(
                    Icons.dinner_dining,
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
                    categoria = 'Doces';
                    setState(() {
                      _scrollToNextCat(18);
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  ),
                  icon: const Icon(
                    Icons.cake_outlined,
                    size: 20.0,
                    color: Colors.black,
                  ),
                  label: Text(
                    'Doces',
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    categoria = 'Bebidas';
                    setState(() {
                      _scrollToNextCat(31);
                    });
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.brown.shade200,
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  ),
                  icon: const Icon(
                    Icons.coffee_outlined,
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

            // BODY
            StreamBuilder<QuerySnapshot>(
              stream: CardapioController().listar(categoria),
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
                    final dados = snapshot.requireData;
                    if (dados.size > 0) {
                      return Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          shrinkWrap: true,
                          itemCount: dados.size,
                          itemBuilder: (context, index) {
                            String id = dados.docs[index].id;
                            dynamic item = dados.docs[index].data();
                            return SizedBox(
                              width: 250,
                              height: itemHeight,
                              child: Card(
                                elevation: 3,
                                child: ListTile(
                                  title: Text(item['nome'],
                                      style: TextStyle(fontSize: 15)),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['categoria'],
                                        style: TextStyle(fontSize: 10),
                                      ),
                                      Text(
                                        'R\$ ${NumberFormat('#,##0.00').format(
                                          item['valor'],
                                        )}',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          CarrinhoController()
                                              .adicionarItemCarrinho(
                                                  context, item['uid']);

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Produto adicionado com sucesso ao pedido!',
                                                      style: TextStyle(
                                                          fontSize: 15)),
                                                  duration:
                                                      Duration(seconds: 2),
                                                  backgroundColor:
                                                      Colors.black54));
                                        },
                                        child: Icon(Icons.add_shopping_cart),
                                      ),
                                      SizedBox(width: 20),
                                      InkWell(
                                        onTap: () {
                                          // abrir detalhes do item
                                          Navigator.pushNamed(
                                              context, 'detalhes',
                                              arguments: id);
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
                      );
                    } else {
                      return Center(
                        child: Text('Nenhum item do cardápio encontrado.'),
                      );
                    }
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
