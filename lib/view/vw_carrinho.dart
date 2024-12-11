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
  double valorTotal = 0.0; // Armazena o valor total

  @override
  void initState() {
    super.initState();
    atualizarValorTotal(); // Atualiza o valor total ao iniciar a tela
  }

  /// Atualiza o valor total do carrinho
  Future<void> atualizarValorTotal() async {
    try {
      final total = await carrinhoController.calcularValorTotal();
      setState(() {
        valorTotal = total; // Atualiza o estado com o valor calculado
      });
    } catch (e) {
      setState(() {
        valorTotal = 0.0; // Em caso de erro, define o total como 0
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
                stream: CarrinhoController().listar(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Erro ao carregar os itens.'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text('Seu pedido está vazio.'),
                    );
                  }

                  final dados = snapshot.requireData;
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
                                'Total: R\$ ${(item.preco * item.quantidade).toStringAsFixed(2)}',
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
                                  // await carrinhoController.removerItemCarrinho(
                                  //     context, item.itemId);
                                  atualizarValorTotal();
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () async {
                                  // await carrinhoController.removerItemCarrinho(
                                  //     context, item.itemId);
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
