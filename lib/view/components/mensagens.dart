import 'package:flutter/material.dart';

void erro(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: TextStyle(fontSize: 15)),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black54));
}

void sucesso(context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg, style: TextStyle(fontSize: 15)),
      duration: Duration(seconds: 2),
      backgroundColor: Colors.black54));
}
