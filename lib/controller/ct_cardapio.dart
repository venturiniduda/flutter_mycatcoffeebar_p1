import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/md_cardapio.dart';
import '../model/md_categorias.dart';

class CardapioController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  adicionar(Cardapio item) {
    db.collection('itens_cardapio').add(item.toJson());
  }

  adicionarCategoria(Categoria cat) {
    db.collection('categorias').add(cat.toJson());
  }

  adicionarItemCarrinho(Cardapio item) {
    db.collection('pedido').add(item.toJson());
  }

  Stream<QuerySnapshot> listar(categoria) {
    var resultado;
    if (categoria == '') {
      resultado = db.collection('itens_cardapio').orderBy('uid');
    } else {
      resultado = db
          .collection('itens_cardapio')
          .where('categoria', isEqualTo: categoria)
          .orderBy('uid');
    }
    return resultado.snapshots();
  }

  Stream<QuerySnapshot> detalhes(id) {
    var resultado = db.collection('itens_cardapio').where('uid', isEqualTo: id);
    return resultado.snapshots();
  }
}
