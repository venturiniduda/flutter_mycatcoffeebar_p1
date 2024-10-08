import 'dart:ffi';

class Cardapio {
  final String codigo;
  final String nome;
  final String categoria;
  final Double valor_unit;
  final Int quantidade;
  final Double valor_total;

  Cardapio(
    this.codigo,
    this.nome,
    this.categoria,
    this.valor_unit,
    this.quantidade,
    this.valor_total,
  );
}
