import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_login.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_carrinho.dart';
import 'package:flutter_mycatcoffeebar_p1/view/components/mensagens.dart';

// to-do:
// lógica atualização status pedido
// lógica zerar carrinho e valor total quando pedido for concluído
// lógica alterar quantidade item
class CarrinhoController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  adicionarItemCarrinho(context, Carrinho pedido) {
    var pedidoExiste = selecionapedidos(LoginController().idUsuario());

    if (pedidoExiste.isNotEmpty) {
      // to-do: adicionar pedido no registro ja existente e dar update
    } else {
      db
          .collection('pedidos')
          .add(pedido.toJson())
          .then((value) => sucesso(context, 'Produto adicionado com sucesso!'))
          .catchError(
              (e) => erro(context, 'Não foi possivel realizar a operação!'));
    }
  }

  // Future<void> adicionarItemCarrinho(
  //     BuildContext context, String uidItem) async {
  //   final uidUsuario = LoginController().idUsuario();

  //   // Buscar pedido atual do usuário
  //   final pedidos = await selecionapedidos(uidUsuario);

  //   if (pedidos == null) {
  //     // Criar um novo pedido
  //     final novoCarrinho = Carrinho(
  //       codigo: uidUsuario,
  //       status: "Preparando",
  //       dataHora: DateTime.now().toIso8601String(),
  //       itens: [
  //         ItemCarrinho(
  //           itemId: uidItem,
  //           preco: await buscarPrecoItem(uidItem),
  //           quantidade: 1,
  //         ),
  //       ],
  //     );

  //     await db
  //         .collection('pedidos')
  //         .doc(uidUsuario)
  //         .set(novoCarrinho.toJson())
  //         .then((_) => sucesso(context, 'Novo pedido criado com sucesso!'))
  //         .catchError((e) => erro(context, 'Erro ao criar novo pedido.'));
  //   } else {
  //     // Atualizar o pedido existente
  //     final carrinhoAtual = Carrinho.fromJson({
  //       "uid": pedidos["uid"],
  //       "status": pedidos["status"],
  //       "data_hora": pedidos["data_hora"],
  //       "itens": pedidos["itens"],
  //     });

  //     final itemExistenteIndex =
  //         carrinhoAtual.itens.indexWhere((item) => item.itemId == uidItem);

  //     if (itemExistenteIndex != -1) {
  //       // O item já existe no carrinho
  //       carrinhoAtual.itens[itemExistenteIndex].quantidade += 1;
  //     } else {
  //       // Adicionar o novo item
  //       carrinhoAtual.itens.add(
  //         ItemCarrinho(
  //           itemId: uidItem,
  //           preco: await buscarPrecoItem(uidItem),
  //           quantidade: 1,
  //         ),
  //       );
  //     }
  //     await db
  //         .collection('pedidos')
  //         .doc(uidUsuario)
  //         .update(carrinhoAtual.toJson())
  //         .then((_) => sucesso(context, 'Item adicionado com sucesso!'))
  //         .catchError(
  //             (e) => erro(context, 'Erro ao adicionar item ao pedido.'));
  //   }
  // }

  selecionapedidos(uidUsuario) {
    // Buscar pedido do usuário pelo UID
    var resultado = db
        .collection('pedidos')
        .where('uid', isEqualTo: uidUsuario)
        .where('status', isEqualTo: "Preparando");

    return resultado.snapshots();
  }

  removerUnidItemCarrinho(context, uidItem) {
    // Buscar o pedidos do usuário
    var pedidos = selecionapedidos(LoginController().idUsuario());

    if (pedidos.isEmpty) {
      // Nenhum pedidos em andamento encontrado
      erro(context, 'Nenhum pedido encontrado para o usuário.');
    } else {
      // Obter os dados do pedidos atual
      final carrinhoAtual = Carrinho.fromJson({
        "uid": pedidos["uid"],
        "status": pedidos["status"],
        "data_hora": pedidos["data_hora"],
        "itens": pedidos["itens"],
      });

      // Localizar o item no carrinho
      var itemExistente =
          carrinhoAtual.itens.firstWhere((item) => item.itemId == uidItem);

      if (itemExistente != null) {
        if (itemExistente.quantidade > 1) {
          // Reduzir a quantidade do item
          itemExistente.quantidade -= 1;
        } else {
          // Remover o item do carrinho
          carrinhoAtual.itens.remove(itemExistente);
        }

        db
            .collection('pedidos')
            .doc(LoginController().idUsuario())
            .update(carrinhoAtual.toJson())
            .then((value) => sucesso(context, 'Item adicionado com sucesso!'))
            .catchError((e) =>
                erro(context, 'Não foi possível adicionar o item ao pedido.'))
            .whenComplete(() => Navigator.pop(context));
      }
    }

    calcularValorTotal();
  }

  Future<void> removerItemCarrinho(context, uidItem) async {
    final uidUsuario = LoginController().idUsuario();

    // Buscar o pedido do usuário
    final pedidos = await selecionapedidos(uidUsuario);

    if (pedidos == null) {
      // Nenhum pedidos em andamento encontrado
      throw Exception("Nenhum pedido encontrado para o usuário.");
    } else {
      // Obter os dados do pedidos atual
      final carrinhoAtual = Carrinho.fromJson({
        "uid": pedidos["uid"],
        "status": pedidos["status"],
        "data_hora": pedidos["data_hora"],
        "itens": pedidos["itens"],
      });

      // Localizar o item no carrinho
      final itemExistente =
          carrinhoAtual.itens.firstWhere((item) => item.itemId == uidItem);

      if (itemExistente != null) {
        // Remover o item do carrinho
        carrinhoAtual.itens.remove(itemExistente);

        db
            .collection('pedidos')
            .doc(LoginController().idUsuario())
            .update(carrinhoAtual.toJson())
            .then((value) => sucesso(context, 'Item adicionado com sucesso!'))
            .catchError((e) =>
                erro(context, 'Não foi possível adicionar o item ao pedido.'))
            .whenComplete(() => Navigator.pop(context));

        calcularValorTotal();
      }
    }
  }

  calcularValorTotal() {
    final uidUsuario = LoginController().idUsuario();

    // Buscar o pedido do usuário
    var pedido = selecionapedidos(uidUsuario);

    if (pedido == null) {
      // Nenhum pedido encontrado, valor total é 0
      return 0.0;
    }

    // Extrair itens do pedido
    var itens = (pedido["itens"] as List<dynamic>).map((item) {
      return ItemCarrinho(
        itemId: item['item_id'],
        preco: item['preco'],
        quantidade: item['quantidade'],
      );
    }).toList();

    // Calcular o total
    double total = itens.fold(0.0, (somaT, item) {
      return somaT + (item.preco * item.quantidade);
    });

    return total;
  }

  Stream<QuerySnapshot> listar() {
    // Retorna o pedido e seus itens
    var resultado = db
        .collection('pedidos')
        .where('uid', isEqualTo: LoginController().idUsuario());
    return resultado.snapshots();
  }
}
