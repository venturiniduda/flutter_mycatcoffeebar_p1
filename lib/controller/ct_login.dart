import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mycatcoffeebar_p1/view/components/mensagens.dart';

class LoginController {
  final FirebaseAuth auth = FirebaseAuth.instance;

  // Criação de um nova conta de usuário no Firebase Authentication
  void criarConta(context, nome, sobrenome, celular, email, senha) {
    auth
        .createUserWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      // Armazenar os dados do usuário no BD
      FirebaseFirestore.instance.collection('usuarios').add(
        {
          'uid': resultado.user!.uid,
          'nome': nome,
          'sobrenome': sobrenome,
          'celular': celular,
        },
      );
      sucesso(context, 'Usuário criado com sucesso!');
      Timer(Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(
          context,
          'login',
          (Route<dynamic> route) => false,
        );
      });
    }).catchError((e) {
      switch (e.code) {
        case 'email-already-in-use':
          erro(context, 'O email já foi cadastrado.');
          break;
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        default:
          erro(context, 'ERRO: ${e.code.toString()}');
      }
    });
  }

  // LOGIN
  void login(context, email, senha) {
    auth
        .signInWithEmailAndPassword(email: email, password: senha)
        .then((resultado) {
      sucesso(context, 'Usuário autenticado com sucesso!');
      Navigator.pushNamed(context, 'cardapio');
    }).catchError((e) {
      switch (e.code) {
        case 'invalid-email':
          erro(context, 'O formato do email é inválido.');
          break;
        default:
          erro(context, 'Erro: ${e.code.toString()}');
      }
    });
  }

  // ESQUECEU A SENHA
  void esqueceuSenha(context, String email) {
    if (email.isNotEmpty) {
      auth.sendPasswordResetEmail(email: email);
      sucesso(context, 'Email para redefinição enviado com sucesso!');
    } else {
      erro(context, 'Informe o email para recuperação.');
    }
    Navigator.pop(context);
  }

  // LOGOUT
  logout() {
    auth.signOut();
  }

  // UID do Usuário Logado - ID Universal do usuário
  idUsuario() {
    return auth.currentUser!.uid;
  }

  // NOME do Usuário Logado
  Future<String> usuarioLogado() async {
    var nome = '';
    await FirebaseFirestore.instance
        .collection('usuarios')
        .where('uid', isEqualTo: idUsuario())
        .get()
        .then((resultado) {
      nome = resultado.docs[0].data()['nome'] ?? '';
    });
    return nome;
  }
}

