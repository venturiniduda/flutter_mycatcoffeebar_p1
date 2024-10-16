import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
      appBar: AppBar(
        title: Text(srv.cardapio[idCardapio].nome,
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple.shade900,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.purple.shade50,
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            exibirCampoTexto('Nome', srv.cardapio[idCardapio].nome),
            exibirCampoTexto('Descrição', srv.cardapio[idCardapio].descricao),
            exibirCampoTexto(
                'Valor',
                NumberFormat('#,##0.00')
                    .format(srv.cardapio[idCardapio].valor.toDouble())),
            SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: Size(double.infinity, 50),
                foregroundColor: Colors.purple.shade900,
                backgroundColor: Colors.purple.shade50,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }

  exibirCampoTexto(label, texto) {
    return ListTile(
      title: Text(label, style: GoogleFonts.reenieBeanie(fontSize: 50)),
      subtitle: Text(texto, style: TextStyle(fontSize: 22)),
    );
  }
}
