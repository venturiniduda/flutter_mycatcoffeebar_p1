import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';
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
        title:
            const Text('Pedido Final', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.purple.shade900,
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.purple.shade50,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: srv.carrinho.length,
          itemBuilder: (context, index) {
            return exibirCampoTexto(
              srv.carrinho[index].nome,
              srv.carrinho[index].quantidade,
              srv.carrinho[index].valorunit,
            );
          },
        ),
      ),
    );
  }

  Widget exibirCampoTexto(String label, int quantidade, double valor) {
    return ListTile(
      title: Text(label, style: const TextStyle(fontSize: 12)),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(NumberFormat('#0').format(quantidade) + 'x',
              style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4), // Espaçamento entre as linhas
          Text(NumberFormat('#,##0.00').format(valor),
              style: const TextStyle(fontSize: 16)), // Texto adicional
        ],
      ),
    );
  }
}
