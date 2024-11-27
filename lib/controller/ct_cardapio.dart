import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/md_cardapio.dart';

class CardapioController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  adicionar(Cardapio item) {
    db.collection('itens_cardapio').add(item.toJson());
  }

  Stream<QuerySnapshot> listar() {
    var resultado = db.collection('itens_cardapio').orderBy('uid');
    return resultado.snapshots();
  }
}
