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

  Stream<QuerySnapshot> listar(String categoria) {
    var resultado;
    if (categoria == "") {
      resultado = db.collection('itens_cardapio').orderBy('uid');
    } else {
      resultado = db
          .collection('itens_cardapio')
          .where('categoria', isEqualTo: categoria);
    }
    return resultado.snapshots();
  }

  Stream<QuerySnapshot> detalhes(uid) {
    var resultado = db.collection('itens_cardapio').where('uid', isEqualTo: uid);
    return resultado.snapshots();
  }
}
