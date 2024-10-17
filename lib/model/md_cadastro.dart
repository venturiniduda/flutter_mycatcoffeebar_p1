import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';

final DadosService srv = GetIt.instance<DadosService>();

class CadastroUser {
  String nome;
  String sobrenome;
  String email;
  String celular;
  String senha;

  CadastroUser(this.nome, this.sobrenome, this.email, this.celular, this.senha);

  static preencher() {
    srv.adicionarUser(
        CadastroUser('Admin', '', 'admin@gmail.com', '0', 'admin'));
  }
}
