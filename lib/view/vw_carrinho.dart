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

  @override
  void initState() {
    super.initState();
    atualizarValorTotal();
  }

  Future<void> atualizarValorTotal() async {
    try {
      final total = await carrinhoController.calcularValorTotal();
      setState(() {
        valorTotal = total;
      });
    } catch (e) {
      setState(() {
        valorTotal = 0.0;
      });
    }
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
            Text(
              'Itens',
              style: GoogleFonts.reenieBeanie(fontSize: 35),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: carrinhoController.listar(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('Erro ao carregar os itens.'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text('Seu pedido está vazio.'),
                    );
                  }

                  final itemDocs = snapshot.data!.docs;
                  final itensCarrinho = itemDocs.expand((doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    final itens =
                        (data['itens'] as List<dynamic>? ?? []).map((item) {
                      return ItemCarrinho(
                        nomeItem: item['nome_item'] ?? 'Item Desconhecido',
                        itemId: item['item_id'] ?? '',
                        preco: (item['preco'] as num?)?.toDouble() ?? 0.0,
                        quantidade: (item['quantidade'] as num?)?.toInt() ?? 0,
                      );
                    });
                    return itens;
                  }).toList();

                  return ListView.builder(
                    itemCount: itensCarrinho.length,
                    itemBuilder: (context, index) {
                      final item = itensCarrinho[index];
                      return Card(
                        child: ListTile(
                          title: Text(
                            item.nomeItem,
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
                                'Total: R\$ ${(item.quantidade * item.preco).toStringAsFixed(2)}',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () async {
                                  await carrinhoController
                                      .adicionarItemCarrinho(
                                          context, item.itemId);
                                  atualizarValorTotal();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () async {
                                  await carrinhoController.removerItemCarrinho(
                                      context, item.itemId);
                                  atualizarValorTotal();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  await carrinhoController
                                      .removerItemFullCarrinho(
                                          context, item.itemId);
                                  atualizarValorTotal();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Valor Total',
              style: GoogleFonts.reenieBeanie(fontSize: 35),
            ),
            const SizedBox(height: 10),
            Text(
              "R\$ ${valorTotal.toStringAsFixed(2)}",
              style: const TextStyle(fontSize: 30),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () async {
                await carrinhoController.concluirPedido(context);
                atualizarValorTotal();
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
