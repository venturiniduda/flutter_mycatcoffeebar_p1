import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/view/components/mensagens.dart';
import '../model/md_cardapio.dart';

class MenuController {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  adicionar(Cardapio item) {
    db.collection('itens_cardapio').add(item.toJson());
    // .then((value) => sucesso(context, 'Cardapio inserido com sucesso!'))
    // .catchError(
    //     (e) => erro(context, 'Não foi possível realizar a operação.'));
  }

  Stream<QuerySnapshot> listar() {
    var resultado = db.collection('itens_cardapio');
    return resultado.snapshots();
  }
}
