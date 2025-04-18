import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_cardapio.dart';
import 'package:flutter_mycatcoffeebar_p1/controller/ct_login.dart';
import 'package:flutter_mycatcoffeebar_p1/model/md_carrinho.dart';
import 'package:flutter_mycatcoffeebar_p1/view/components/mensagens.dart';

class CarrinhoController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<void> adicionarItemCarrinho(context, uidItem) async {
    try {
      final item;
      var pedidoSnapshot =
          await selecionapedidos(LoginController().idUsuario()).first;
      final pedidoDocs = pedidoSnapshot.docs;

      final itemSnapshot = await CardapioController().detalhes(uidItem).first;
      final itemDocs = itemSnapshot.docs;

      if (itemDocs.isEmpty) {
        erro(context, 'Item não encontrado!');
        return;
      } else {
        item = itemDocs.first.data() as Map<String, dynamic>;
      }

      if (pedidoDocs.isEmpty) {
        // Criar um novo pedido
        final novoCarrinho = Carrinho(
          codigo: LoginController().idUsuario(),
          status: "Preparando",
          dataHora: DateTime.now().toIso8601String(),
          itens: [
            ItemCarrinho(
              nomeItem: item['nome'],
              itemId: item['uid'],
              preco: item['valor'],
              quantidade: 1,
            ),
          ],
        );

        await db.collection('pedidos').add(novoCarrinho.toJson());
        sucesso(context, 'Novo pedido criado com sucesso!');
      } else {
        // Atualiza o carrinho existente
        final carrinhoDoc = pedidoDocs.first;
        final carrinhoData = carrinhoDoc.data() as Map<String, dynamic>;
        final carrinhoAtual = Carrinho.fromJson(carrinhoData);

        // Verifica se o item já está no carrinho
        final indexItemExistente =
            carrinhoAtual.itens.indexWhere((e) => e.itemId == uidItem);

        if (indexItemExistente >= 0) {
          // Atualiza a quantidade do item existente
          int quantidade =
              carrinhoAtual.itens[indexItemExistente].quantidade + 1;

          carrinhoAtual.itens[indexItemExistente] = ItemCarrinho(
            nomeItem: carrinhoAtual.itens[indexItemExistente].nomeItem,
            itemId: carrinhoAtual.itens[indexItemExistente].itemId,
            preco: carrinhoAtual.itens[indexItemExistente].preco,
            quantidade: quantidade,
          );
        } else {
          // Adiciona o novo item ao carrinho
          var itemNew = ItemCarrinho(
            nomeItem: item['nome'],
            itemId: item['uid'],
            preco: item['valor'],
            quantidade: 1,
          );

          carrinhoAtual.itens.add(itemNew);
        }

        // Atualiza o carrinho no Firestore
        await db
            .collection('pedidos')
            .doc(carrinhoDoc.id)
            .update(carrinhoAtual.toJson());
        sucesso(context, 'Item adicionado ao carrinho existente!');
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

  Future<void> concluirPedido(context) async {
    try {
      var pedidoSnapshot =
          await selecionapedidos(LoginController().idUsuario()).first;
      final pedidoDocs = pedidoSnapshot.docs;

      // Atualiza o carrinho existente
      final carrinhoDoc = pedidoDocs.first;
      final carrinhoData = carrinhoDoc.data() as Map<String, dynamic>;
      var carrinhoAtual = Carrinho.fromJson(carrinhoData);

      carrinhoAtual = Carrinho(
          codigo: carrinhoAtual.codigo,
          status: "Concluído",
          dataHora: carrinhoAtual.dataHora,
          itens: carrinhoAtual.itens);

      // Atualiza o carrinho no Firestore
      await db
          .collection('pedidos')
          .doc(carrinhoDoc.id)
          .update(carrinhoAtual.toJson());
      sucesso(context, 'Pedido Concluído!');
    } catch (e) {
      erro(context, 'Erro ao concluir o pedido: $e');
    }
  }

  Future<void> removerItemCarrinho(context, uidItem) async {
    try {
      final item;
      var pedidoSnapshot =
          await selecionapedidos(LoginController().idUsuario()).first;
      final pedidoDocs = pedidoSnapshot.docs;

      final itemSnapshot = await CardapioController().detalhes(uidItem).first;
      final itemDocs = itemSnapshot.docs;

      if (itemDocs.isEmpty) {
        erro(context, 'Item não encontrado!');
        return;
      } else {
        item = itemDocs.first.data() as Map<String, dynamic>;
      }

      // Atualiza o carrinho existente
      final carrinhoDoc = pedidoDocs.first;
      final carrinhoData = carrinhoDoc.data() as Map<String, dynamic>;
      final carrinhoAtual = Carrinho.fromJson(carrinhoData);

      // Verifica se o item já está no carrinho
      final indexItemExistente =
          carrinhoAtual.itens.indexWhere((e) => e.itemId == uidItem);

      if (indexItemExistente >= 0) {
        // Atualiza a quantidade do item existente
        int quantidade = carrinhoAtual.itens[indexItemExistente].quantidade;

        if (quantidade > 1) {
          quantidade--;
          carrinhoAtual.itens[indexItemExistente] = ItemCarrinho(
            nomeItem: carrinhoAtual.itens[indexItemExistente].nomeItem,
            itemId: carrinhoAtual.itens[indexItemExistente].itemId,
            preco: carrinhoAtual.itens[indexItemExistente].preco,
            quantidade: quantidade,
          );
        } else {
          carrinhoAtual.itens.removeAt(indexItemExistente);
        }
      }

      // Atualiza o carrinho no Firestore
      await db
          .collection('pedidos')
          .doc(carrinhoDoc.id)
          .update(carrinhoAtual.toJson());
      sucesso(context, 'Item removido!');
    } catch (e) {
      erro(context, 'Erro ao remover item do carrinho: $e');
    }

    calcularValorTotal();
  }

  Future<void> removerItemFullCarrinho(context, uidItem) async {
    try {
      final item;
      var pedidoSnapshot =
          await selecionapedidos(LoginController().idUsuario()).first;
      final pedidoDocs = pedidoSnapshot.docs;

      final itemSnapshot = await CardapioController().detalhes(uidItem).first;
      final itemDocs = itemSnapshot.docs;

      if (itemDocs.isEmpty) {
        erro(context, 'Item não encontrado!');
        return;
      } else {
        item = itemDocs.first.data() as Map<String, dynamic>;
      }

      // Atualiza o carrinho existente
      final carrinhoDoc = pedidoDocs.first;
      final carrinhoData = carrinhoDoc.data() as Map<String, dynamic>;
      final carrinhoAtual = Carrinho.fromJson(carrinhoData);

      // Verifica se o item já está no carrinho
      final indexItemExistente =
          carrinhoAtual.itens.indexWhere((e) => e.itemId == uidItem);

      var itemBye = ItemCarrinho(
          nomeItem: carrinhoAtual.itens[indexItemExistente].nomeItem,
          itemId: carrinhoAtual.itens[indexItemExistente].itemId,
          preco: carrinhoAtual.itens[indexItemExistente].preco,
          quantidade: carrinhoAtual.itens[indexItemExistente].quantidade);

      if (indexItemExistente >= 0) {
        // Remove o item
        carrinhoAtual.itens.removeAt(indexItemExistente);

        // Atualiza o carrinho no Firestore
        await db
            .collection('pedidos')
            .doc(carrinhoDoc.id)
            .update(carrinhoAtual.toJson());
        sucesso(context, 'Item removido!');

        calcularValorTotal();
      }
    } catch (e) {
      erro(context, 'Erro ao remover item do carrinho: $e');
    }
  }

  Future<double> calcularValorTotal() async {
    try {
      // Buscar o pedido do usuário
      var pedidoSnapshot =
          await selecionapedidos(LoginController().idUsuario()).first;
      final pedidoDocs = pedidoSnapshot.docs;

      if (pedidoDocs.isEmpty) {
        // Nenhum pedido encontrado, valor total é 0
        return 0.0;
      }

      final pedidoDoc = pedidoDocs.first;
      final pedidoData = pedidoDoc.data() as Map<String, dynamic>;
      final pedidoAtual = Carrinho.fromJson(pedidoData);
      double total = 0.00;

      for (final item in pedidoAtual.itens) {
        total = total + (item.preco * item.quantidade);
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  Stream<QuerySnapshot> listar() {
    // Retorna o pedido e seus itens
    var resultado = db
        .collection('pedidos')
        .where('uid', isEqualTo: LoginController().idUsuario())
        .where('status', isEqualTo: "Preparando");
    return resultado.snapshots();
  }
}
