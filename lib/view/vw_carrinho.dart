import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_carrinho.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_carrinho.dart';
import 'package:google_fonts/google_fonts.dart';

final CarrinhoController carrinhoController = CarrinhoController();

class CarrinhoView extends StatefulWidget {
  const CarrinhoView({super.key});

  @override
  State<CarrinhoView> createState() => _CarrinhoViewState();
}

class _CarrinhoViewState extends State<CarrinhoView> {
  double valorTotal = 0.0;

  void initState() {
    super.initState();
    atualizarValorTotal();
  }

  Future<void> atualizarValorTotal() async {
    final total = await carrinhoController.calcularValorTotal();
    setState(() {
      valorTotal = total;
    });
  }

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
            Text('Itens',
                style: GoogleFonts.reenieBeanie(
                  fontSize: 35,
                )),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
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
                      final dados = snapshot.requireData;
                      if (dados.size > 0) {
                        final itensCarrinho = dados.docs.map((doc) {
                          final data = doc.data() as Map<String, dynamic>;
                          return ItemCarrinho(
                            itemId: data['item_id'],
                            preco: data['preco'],
                            quantidade: data['quantidade'],
                          );
                        }).toList();

                        return ListView.builder(
                          itemCount: itensCarrinho.length,
                          itemBuilder: (context, index) {
                            final item = itensCarrinho[index];
                            return Card(
                              child: ListTile(
                                title: Text(
                                  'Item: ${item.itemId}',
                                  style: const TextStyle(fontSize: 22),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Quantidade: ${item.quantidade}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Valor unitário: R\$ ${item.preco.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                    Text(
                                      'Total: R\$ ${valorTotal.toStringAsFixed(2)}',
                                      style: const TextStyle(fontSize: 14),
                                    ),
                                  ],
                                ),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.add),
                                      onPressed: () {
                                        carrinhoController
                                            .adicionarItemCarrinho(
                                                context, item);
                                        setState(() {});
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () async {
                                        // await carrinhoController
                                        //     .removerItemCarrinho(
                                        //         context, item.itemId);
                                        // setState(() {});
                                      },
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () async {
                                        // await carrinhoController
                                        //     .removerItemCarrinho(
                                        //         context, item.itemId);
                                        // setState(() {});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('Seu pedido está vazio.'),
                        );
                      }
                  }
                },
              ),
            ),
            const SizedBox(height: 20),
            Text('Valor Total',
                style: GoogleFonts.reenieBeanie(
                  fontSize: 35,
                )),
            const SizedBox(height: 10),
            Text(
              "R\$ ${carrinhoController.calcularValorTotal()}",
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Pedido confirmado! Obrigada.'),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.black54,
                  ),
                );
              },
              icon: const Icon(Icons.restaurant),
              style: ElevatedButton.styleFrom(iconColor: Colors.black),
              label: const Text(
                'Confirmar o Pedido',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
