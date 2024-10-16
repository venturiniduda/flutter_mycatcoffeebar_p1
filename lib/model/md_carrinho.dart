class Carrinho {
  final String codigo;
  final String nome;
  final String categoria;
  final double valorunit;
  int quantidade;
  double valorTotalItm;

  Carrinho(
    this.codigo,
    this.nome,
    this.categoria,
    this.valorunit,
    this.quantidade,
    this.valorTotalItm,
  );
}
