import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final DadosService srv = GetIt.instance<DadosService>();

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
            padding: EdgeInsets.only(right: 30),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'cardapio');
            },
            icon: const Icon(Icons.menu_book, size: 25.0),
            color: Colors.black,
            tooltip: 'Abrir Cardápio',
            alignment: Alignment.centerRight,
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
              child: SizedBox(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: srv.carrinho.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(srv.carrinho[index].nome,
                            style: TextStyle(fontSize: 22)),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                'Quantidade: ${NumberFormat('#0').format(srv.carrinho[index].quantidade)}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left),
                            Text(
                                'Valor unitário: R\$ ${NumberFormat('#,##0.00').format(srv.carrinho[index].valorunit)}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left),
                            Text(
                                'Total: R\$ ${NumberFormat('#,##0.00').format(srv.carrinho[index].valorTotalItm)}',
                                style: TextStyle(fontSize: 14),
                                textAlign: TextAlign.left),
                          ],
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  srv.adicionarCarrinho(srv.carrinho[index]);
                                });
                              },
                              child: Icon(Icons.add),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                // remover uma unidade do item no pedido
                                setState(() {
                                  srv.removerUnidCarrinho(index);
                                });
                              },
                              child: Icon(Icons.remove),
                            ),
                            SizedBox(height: 20),
                            InkWell(
                              onTap: () {
                                // remover o item do pedido
                                setState(() {
                                  srv.removerItmCarrinho(index);
                                });
                              },
                              child: Icon(Icons.delete),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Valor Total',
                style: GoogleFonts.reenieBeanie(
                  fontSize: 35,
                )),
            SizedBox(height: 10),
            Text(
              "R\$ ${NumberFormat('#,##0.00').format(srv.valorTotal)}",
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Pedido confirmado! Obrigada.',
                        style: TextStyle(fontSize: 15)),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.black54));
              },
              icon: Icon(Icons.restaurant),
              style: ElevatedButton.styleFrom(iconColor: Colors.black),
              label: Text(
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
