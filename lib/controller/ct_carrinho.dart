import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_cardapio.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_login.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_carrinho.dart';
import 'package:flutter_mycatcoffeebar_p1/view/components/mensagens.dart';

// to-do:
// lógica atualização status pedido
// lógica zerar carrinho e valor total quando pedido for concluído
// lógica alterar quantidade item

class CarrinhoController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> adicionarItemCarrinho(context, uidItem) async {
    try {
      var pedidoSnapshot =
          await selecionapedidos(LoginController().idUsuario()).first;
      final pedidoDocs = pedidoSnapshot.docs;
      final pedido = pedidoDocs.first.data() as Map<String, dynamic>;

      final itemSnapshot = await CardapioController().detalhes(uidItem).first;
      final itemDocs = itemSnapshot.docs;

      if (itemDocs.isEmpty) {
        erro(context, 'Item não encontrado!');
        return;
      }

      final item = itemDocs.first.data() as Map<String, dynamic>;

      if (pedidoDocs.isEmpty) {
        // Criar um novo pedido
        final novoCarrinho = Carrinho(
          codigo: LoginController().idUsuario(),
          status: "Preparando",
          dataHora: DateTime.now().toIso8601String(),
          itens: [
            ItemCarrinho(
              itemId: item['uid'],
              preco: item['preco'],
              quantidade: 1,
            ),
          ],
        );

        await db
            .collection('pedidos')
            .doc(LoginController().idUsuario())
            .set(novoCarrinho.toJson());
        sucesso(context, 'Novo pedido criado com sucesso!');
      } else {
        // Atualizar o pedido existente
        final carrinhoAtual = Carrinho.fromJson(pedido);

        // Verificar se o item já está no carrinho
        final indexItem =
            carrinhoAtual.itens.indexWhere((e) => e.itemId == item['uid']);
        if (indexItem >= 0) {
          // Incrementar a quantidade do item existente
          carrinhoAtual.itens[indexItem].quantidade++;
        } else {
          // Adicionar novo item ao carrinho
          carrinhoAtual.itens.add(ItemCarrinho(
            itemId: item['uid'],
            preco: item['preco'],
            quantidade: 1,
          ));
        }

        // Atualizar o pedido no Firestore
        await db
            .collection('pedidos')
            .doc(LoginController().idUsuario())
            .update(carrinhoAtual.toJson());
        sucesso(context, 'Item adicionado ao pedido existente!');
      }
    } catch (e) {
      erro(context, 'Erro ao adicionar item ao carrinho: $e');
    }
  }

  Stream<QuerySnapshot> selecionapedidos(uidUsuario) {
    // Buscar pedido do usuário pelo UID
    var resultado = db
        .collection('pedidos')
        .where('uid', isEqualTo: uidUsuario)
        .where('status', isEqualTo: "Preparando");

    return resultado.snapshots();
  }

  removerUnidItemCarrinho(context, uidItem) {
    // // Buscar o pedidos do usuário
    // var pedidos = selecionapedidos(LoginController().idUsuario());

    // if (pedidos.isEmpty) {
    //   // Nenhum pedidos em andamento encontrado
    //   erro(context, 'Nenhum pedido encontrado para o usuário.');
    // } else {
    //   // Obter os dados do pedidos atual
    //   final carrinhoAtual = Carrinho.fromJson({
    //     "uid": pedidos["uid"],
    //     "status": pedidos["status"],
    //     "data_hora": pedidos["data_hora"],
    //     "itens": pedidos["itens"],
    //   });

    //   // Localizar o item no carrinho
    //   var itemExistente =
    //       carrinhoAtual.itens.firstWhere((item) => item.itemId == uidItem);

    //   if (itemExistente.requireData.size > 0) {
    //     if (itemExistente.quantidade > 1) {
    //       // Reduzir a quantidade do item
    //       itemExistente.quantidade -= 1;
    //     } else {
    //       // Remover o item do carrinho
    //       carrinhoAtual.itens.remove(itemExistente);
    //     }

    //     db
    //         .collection('pedidos')
    //         .doc(LoginController().idUsuario())
    //         .update(carrinhoAtual.toJson())
    //         .then((value) => sucesso(context, 'Item adicionado com sucesso!'))
    //         .catchError((e) =>
    //             erro(context, 'Não foi possível adicionar o item ao pedido.'))
    //         .whenComplete(() => Navigator.pop(context));
    //   }
    // }

    db
        .collection('pedidos')
        .doc(uidItem)
        .delete()
        .then((value) => sucesso(context, 'Produto removido com sucesso!'))
        .catchError(
            (e) => erro(context, 'Não foi possivel realizar a operação!'));

    calcularValorTotal();
  }

  // Future<void> removerItemCarrinho(context, uidItem) async {
  //   final uidUsuario = LoginController().idUsuario();

  //   // Buscar o pedido do usuário
  //   final pedidos = await selecionapedidos(uidUsuario);

  //   if (pedidos == null) {
  //     // Nenhum pedidos em andamento encontrado
  //     throw Exception("Nenhum pedido encontrado para o usuário.");
  //   } else {
  //     // Obter os dados do pedidos atual
  //     final carrinhoAtual = Carrinho.fromJson({
  //       "uid": pedidos["uid"],
  //       "status": pedidos["status"],
  //       "data_hora": pedidos["data_hora"],
  //       "itens": pedidos["itens"],
  //     });

  //     // Localizar o item no carrinho
  //     final itemExistente =
  //         carrinhoAtual.itens.firstWhere((item) => item.itemId == uidItem);

  //     if (itemExistente != null) {
  //       // Remover o item do carrinho
  //       carrinhoAtual.itens.remove(itemExistente);

  //       db
  //           .collection('pedidos')
  //           .doc(LoginController().idUsuario())
  //           .update(carrinhoAtual.toJson())
  //           .then((value) => sucesso(context, 'Item adicionado com sucesso!'))
  //           .catchError((e) =>
  //               erro(context, 'Não foi possível adicionar o item ao pedido.'))
  //           .whenComplete(() => Navigator.pop(context));

  //       calcularValorTotal();
  //     }
  //   }
  // }

  Future<double> calcularValorTotal() async {
    try {
      // Buscar o pedido do usuário
      var pedidoSnapshot =
          await selecionapedidos(LoginController().idUsuario()).first;
      final pedidoDocs = pedidoSnapshot.docs;
      final pedido = pedidoDocs.first.data() as Map<String, dynamic>;

      if (pedidoDocs.isEmpty) {
        // Nenhum pedido encontrado, valor total é 0
        return 0.0;
      }

      // Extrair itens do pedido
      var itens = (pedido['itens'] as List<dynamic>).map((item) {
        return ItemCarrinho(
          itemId: item['item_id'],
          preco: (item['preco'] as num).toDouble(),
          quantidade: item['quantidade'],
        );
      }).toList();

      // Calcular o total
      double total = itens.fold(0.0, (somaT, item) {
        return somaT + (item.preco * item.quantidade);
      });

      return total;
    } catch (e) {
      // Caso ocorra algum erro, retorna 0 e pode exibir logs adicionais
      return 0.0;
    }
  }

  Stream<QuerySnapshot> listar() {
    // Retorna o pedido e seus itens
    var resultado = db
        .collection('pedidos')
        .where('uid', isEqualTo: LoginController().idUsuario());
    return resultado.snapshots();
  }
}
