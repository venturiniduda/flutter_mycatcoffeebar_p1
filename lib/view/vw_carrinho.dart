import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

// to do:
// - titulo: resumo do pedido
// - adicionar funcionalidades de remover ou adicionar itens ao pedido (altera somente a quantidade)
//    -> a soma da quantidade deve ser feita na srv, verificando se ja existe o item no carrinho com o mesmo codigo, se sim adiciona no msm
// - adicionar funcionalidade de remover completamente o item do pedido
// - deve ter um valor unitario e o total de cada item (unitario x qntd)
// - deve ter o valor final do pedido
// - deve ter um botão confirmar pedido, e uma mensagem depois de clicar no botão

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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Itens',
                style: GoogleFonts.reenieBeanie(
                  fontSize: 35,
                )),
            ListView.builder(
              shrinkWrap: true,
              itemCount: srv.carrinho.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(srv.carrinho[index].nome,
                        style: TextStyle(fontSize: 22)),
                    subtitle: Column(
                      children: [
                        Text(
                            'Quantidade: ${NumberFormat('#0').format(srv.carrinho[index].quantidade)}',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.left),
                        Text(
                            'Valor unitário: ${NumberFormat('#,##0.00').format(srv.carrinho[index].valorunit)}',
                            style: TextStyle(fontSize: 14),
                            textAlign: TextAlign.left),
                        Text(
                            'Total: ${NumberFormat('#,##0.00').format(srv.carrinho[index].valorTotalItm)}',
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
                        SizedBox(width: 20),
                        InkWell(
                          onTap: () {
                            // remover uma unidade do item no pedido
                            setState(() {
                              srv.removerUnidCarrinho(index);
                            });
                          },
                          child: Icon(Icons.remove),
                        ),
                        SizedBox(width: 20),
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
            SizedBox(width: 20),
            Text('Valor Total',
                style: GoogleFonts.reenieBeanie(
                  fontSize: 35,
                )),
            SizedBox(width: 10),
            Text(
              "R\$ ${NumberFormat('#,##0.00').format(srv.valorTotal)}",
              style: TextStyle(fontSize: 30),
            )
            // adicionar botões confirmação pedido aqui
          ],
        ),
      ),
    );
  }
}
