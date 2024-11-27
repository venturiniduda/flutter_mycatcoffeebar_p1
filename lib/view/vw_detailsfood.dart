import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_cardapio.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../model/md_carrinho.dart';

final DadosService srv = GetIt.instance<DadosService>();

class DetalhesView extends StatefulWidget {
  const DetalhesView({super.key});

  @override
  State<DetalhesView> createState() => _DetalhesViewState();
}

class _DetalhesViewState extends State<DetalhesView> {
  @override
  Widget build(BuildContext context) {
    final int idCardapio = ModalRoute.of(context)!.settings.arguments as int;
    srv.retornarCardapio(idCardapio);

    return Scaffold(
      backgroundColor: Colors.brown.shade100,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: StreamBuilder<QuerySnapshot>(
          stream: CardapioController().detalhes(idCardapio),
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
                  final item = snapshot.data!.docs.first.data();
                  return ListView(
                    children: [
                      Container(
                        height: 300,
                        width: 150,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50.0)),
                        child: Image.asset(
                          item['imagem'],
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        item['nome'],
                        style: GoogleFonts.reenieBeanie(
                            fontSize: 45, letterSpacing: 0.5),
                        textAlign: TextAlign.center,
                      ),
                      exibirCampoTexto('Mais detalhes', item['descricao']),
                      exibirCampoTexto('Valor',
                          'R\$ ${NumberFormat('#,##0.00').format(item['valor'].toDouble())}'),
                      SizedBox(height: 5),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon:
                                const Icon(Icons.arrow_circle_left, size: 45.0),
                            color: Colors.brown.shade500,
                            tooltip: 'Voltar',
                          ),
                          IconButton(
                            onPressed: () {
                              srv.adicionarCarrinho(Carrinho(
                                  item['uid'],
                                  item['nome'],
                                  item['categoria'],
                                  item['valor'],
                                  1,
                                  0));

                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Produto adicionado com sucesso ao pedido!',
                                      style: TextStyle(fontSize: 15)),
                                  duration: Duration(seconds: 1),
                                  backgroundColor: Colors.black54));
                            },
                            icon: const Icon(Icons.add_circle, size: 45.0),
                            color: Colors.blue.shade500,
                            tooltip: 'Adicionar ao Pedido',
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('Nenhuma tarefa encontrada.'),
                  );
                }
            }
          },
        ),
      ),
    );
  }

  exibirCampoTexto(label, texto) {
    return ListTile(
      title: Text(label,
          style: GoogleFonts.reenieBeanie(
              fontSize: 25, color: Colors.brown.shade700)),
      subtitle:
          Text(texto, style: TextStyle(fontSize: 20, color: Colors.black)),
    );
  }
}
