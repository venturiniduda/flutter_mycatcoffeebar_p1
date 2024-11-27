import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

  Cardapio retornarCardapio(id) {
    return cardapio[id];
  }

  // FUNÇÕES PARA O CARRINHO DE PEDIDO
  int? obterIndexItem(String codigo) {
    for (int i = 0; i < carrinho.length; i++) {
      if (carrinho[i].codigo == codigo) {
        return i;
      }
    }
    return null;
  }

  void adicionarCarrinho(Carrinho item) {
    var index = obterIndexItem(item.codigo);
    if (index == null) {
      item.valorTotalItm = item.valorunit;
      carrinho.add(item);
    } else {
      carrinho[index].quantidade = carrinho[index].quantidade + 1;
      carrinho[index].valorTotalItm =
          carrinho[index].valorunit * carrinho[index].quantidade;
    }
    valorTotal = valorTotal + item.valorunit;
  }

  void removerUnidCarrinho(index) {
    if (carrinho[index].quantidade == 1) {
      removerItmCarrinho(index);
    } else {
      carrinho[index].quantidade = carrinho[index].quantidade - 1;
      carrinho[index].valorTotalItm =
          carrinho[index].valorunit * carrinho[index].quantidade;
    }
  }

  void removerItmCarrinho(index) {
    carrinho.removeAt(index);
  }
}
