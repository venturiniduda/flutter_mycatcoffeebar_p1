import 'package:flutter/material.dart';
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
        child: ListView(
          children: [
            Container(
              height: 300,
              width: 150,
              clipBehavior: Clip.hardEdge,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
              child: Image.asset(
                srv.cardapio[idCardapio].imagem,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10),
            Text(
              srv.cardapio[idCardapio].nome,
              style: GoogleFonts.reenieBeanie(fontSize: 45, letterSpacing: 0.5),
              textAlign: TextAlign.center,
            ),
            exibirCampoTexto(
                'Mais detalhes', srv.cardapio[idCardapio].descricao),
            exibirCampoTexto(
                'Valor',
                NumberFormat('#,##0.00')
                    .format(srv.cardapio[idCardapio].valor.toDouble())),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_circle_left, size: 45.0),
                  color: Colors.brown.shade500,
                  tooltip: 'Voltar',
                ),
                IconButton(
                  onPressed: () {
                    srv.adicionarCarrinho(Carrinho(
                        srv.cardapio[idCardapio].codigo,
                        srv.cardapio[idCardapio].nome,
                        srv.cardapio[idCardapio].categoria,
                        srv.cardapio[idCardapio].valor,
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
          Text(texto, style: TextStyle(fontSize: 25, color: Colors.black)),
    );
  }
}
