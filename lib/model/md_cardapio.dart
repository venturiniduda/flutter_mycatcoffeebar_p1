import 'dart:ffi';

class Cardapio {
  final String codigo;
  final String nome;
  final String descricao;
  final String categoria;
  final Double valor;

  Cardapio(
    this.codigo,
    this.nome,
    this.descricao,
    this.categoria,
    this.valor,
  );

}