import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../model/md_carrinho.dart';

// to do:
// - formatar style
// - adicionar imagem (deve ser no topo da tela)
// - nome do item logo abaixo da imagem
// - descrição do item que inclua informações sobre ingredientes,
// preparo, características especiais e quaisquer outras informações relevantes.
// - preço deve estar destacado !!!
// - adicionar funcionalidade adicionar o item ao pedido (deve ser na parte inferior da tela)
// - adicionar confirmação de item adicionado ao pedido

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
            Image.asset(
              srv.cardapio[idCardapio].imagem,
              height: 250,
              width: 350,
            ),
            SizedBox(width: 8),
            Text(
              srv.cardapio[idCardapio].nome,
              style: GoogleFonts.reenieBeanie(fontSize: 45, letterSpacing: 0.5),
              textAlign: TextAlign.center,
            ),
            SizedBox(width: 8),
            exibirCampoTexto(
                'Mais detalhes', srv.cardapio[idCardapio].descricao),
            exibirCampoTexto(
                'Valor',
                NumberFormat('#,##0.00')
                    .format(srv.cardapio[idCardapio].valor.toDouble())),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.undo, size: 45.0),
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
                        1));
                  },
                  icon: const Icon(Icons.add_circle, size: 45.0),
                  color: Colors.brown.shade500,
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
