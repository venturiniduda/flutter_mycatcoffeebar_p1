import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';

final DadosService srv = GetIt.instance<DadosService>();

class Categoria {
  final String codigo;
  final String nome;
  final String descricao;

  // Construtor
  Categoria(this.codigo, this.nome, this.descricao);

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'uid': codigo,
      'nome': nome,
      'descricao': descricao
    };
  }

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(json['uid'], json['nome'], json['descricao']);
  }

  static preencher() {
    return [
      Categoria('001', 'Entrada', 'Entradas deliciosas para começar!'),
      Categoria(
          '002', 'Prato Principal', 'Pratos divinos para matar sua fome!'),
      Categoria('003', 'Doce', 'Docinhos para alegrar o dia!'),
      Categoria('004', 'Bebida', 'Bebidas para todos os gostos e ocasiões!')
    ];
  }
}
