import 'package:flutter_mycatcoffeebar_p1/model/md_categorias.dart';
import '../model/md_cardapio.dart';
import '../model/md_carrinho.dart';
import '../controller/ct_cardapio.dart';

class DadosService {
  List<Cardapio> cardapio = [];
  List<Categoria> categoria = [];
  List<Carrinho> carrinho = [];
  double valorTotal = 0;

  // FUNÇÕES PARA O CARDÁPIO
  void preencherListaCardapio() {
    cardapio = Cardapio.preencher();

    for (Cardapio item in cardapio) {
      CardapioController().adicionar(item);
    }
    ;
  }

  void preencherCategorias() {
    categoria = Categoria.preencher();

    for (Categoria cat in categoria) {
      CardapioController().adicionarCategoria(cat);
    }
    ;
  }
}
