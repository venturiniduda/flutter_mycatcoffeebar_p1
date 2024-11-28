import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_login.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_carrinho.dart';
import 'package:flutter_mycatcoffeebar_p1/view/components/mensagens.dart';

class CarrinhoController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> adicionarItemCarrinho(context, uidItem) async {
    final uidUsuario = LoginController().idUsuario();

    // Buscar o pedido do usuário
    final pedido = await selecionaPedido(uidUsuario);

    if (pedido == null) {
      // Criar novo pedido com o primeiro item
      final novoCarrinho = Carrinho(
        codigo: uidUsuario,
        status: "Preparando",
        dataHora: DateTime.now().toIso8601String(),
        itens: [
          ItemCarrinho(
            itemId: uidItem,
            preco: await buscarPrecoItem(uidItem),
            quantidade: 1,
          ),
        ],
      );

      // Enviar o pedido para o Firestore
      await db.collection('pedido').add(novoCarrinho.toJson());
    } else {
      // Obter os dados do pedido atual
      final carrinhoAtual = Carrinho.fromJson({
        "uid": pedido["uid"],
        "status": pedido["status"],
        "data_hora": pedido["data_hora"],
        "itens": pedido["itens"],
      });

      // Verificar se o item já existe no pedido
      final itemExistente = carrinhoAtual.itens.firstWhere(
        (item) => item.itemId == uidItem,
      );

      if (itemExistente != null) {
        // Incrementar a quantidade do item existente
        itemExistente.quantidade += 1;
      } else {
        // Adicionar novo item ao carrinho
        carrinhoAtual.itens.add(
          ItemCarrinho(
            itemId: uidItem,
            preco: await buscarPrecoItem(uidItem),
            quantidade: 1,
          ),
        );
      }

      // Atualizar o pedido no Firestore
      db
          .collection('pedido')
          .doc(LoginController().idUsuario())
          .update(carrinhoAtual.toJson())
          .then((value) => sucesso(context, 'Item adicionado com sucesso!'))
          .catchError((e) =>
              erro(context, 'Não foi possível adicionar o item ao pedido.'))
          .whenComplete(() => Navigator.pop(context));
    }
  }

  Future<Map<String, dynamic>?> selecionaPedido(String uidUsuario) async {
    // Buscar pedido do usuário pelo UID
    final querySnapshot = await db
        .collection('pedido')
        .where('uid', isEqualTo: uidUsuario)
        .where('status', isEqualTo: "Preparando")
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      final doc = querySnapshot.docs.first;
      return {
        "ref": doc.reference,
        "uid": doc["uid"],
        "status": doc["status"],
        "data_hora": doc["data_hora"],
        "itens": doc["itens"],
      };
    }

    // Retorna null se nenhum pedido for encontrado
    return null;
  }

  Future<void> removerUnidItemCarrinho(context, uidItem) async {
    final uidUsuario = LoginController().idUsuario();

    // Buscar o pedido do usuário
    final pedido = await selecionaPedido(uidUsuario);

    if (pedido == null) {
      // Nenhum pedido em andamento encontrado
      throw Exception("Nenhum pedido encontrado para o usuário.");
    } else {
      // Obter os dados do pedido atual
      final carrinhoAtual = Carrinho.fromJson({
        "uid": pedido["uid"],
        "status": pedido["status"],
        "data_hora": pedido["data_hora"],
        "itens": pedido["itens"],
      });

      // Localizar o item no carrinho
      final itemExistente =
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
            .collection('pedido')
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
    final pedido = await selecionaPedido(uidUsuario);

    if (pedido == null) {
      // Nenhum pedido em andamento encontrado
      throw Exception("Nenhum pedido encontrado para o usuário.");
    } else {
      // Obter os dados do pedido atual
      final carrinhoAtual = Carrinho.fromJson({
        "uid": pedido["uid"],
        "status": pedido["status"],
        "data_hora": pedido["data_hora"],
        "itens": pedido["itens"],
      });

      // Localizar o item no carrinho
      final itemExistente =
          carrinhoAtual.itens.firstWhere((item) => item.itemId == uidItem);

      if (itemExistente != null) {
        // Remover o item do carrinho
        carrinhoAtual.itens.remove(itemExistente);

        db
            .collection('pedido')
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

  Future<double> buscarPrecoItem(String uidItem) async {
    // Buscar informações do item
    final item = await db.collection('itens_cardapio').doc(uidItem).get();
    if (item.exists) {
      return item['preco'].toDouble();
    }
    throw Exception("Item não encontrado");
  }

  Future<double> calcularValorTotal() async {
    final uidUsuario = LoginController().idUsuario();

    // Buscar o pedido do usuário
    final pedido = await selecionaPedido(uidUsuario);

    if (pedido == null) {
      // Nenhum pedido encontrado, valor total é 0
      return 0.0;
    }

    // Extrair itens do pedido
    final itens = (pedido["itens"] as List<dynamic>).map((item) {
      return ItemCarrinho(
        itemId: item['item_id'],
        preco: item['preco'],
        quantidade: item['quantidade'],
      );
    }).toList();

    // Calcular o total
    double total = itens.fold(0.0, (sum, item) {
      return sum + (item.preco * item.quantidade);
    });

    return total;
  }

  Stream<QuerySnapshot> listar() {
    // Retorna o pedido e seus itens
    return db
        .collection('pedido')
        .where('uid', isEqualTo: LoginController().idUsuario())
        .snapshots();
  }
}
