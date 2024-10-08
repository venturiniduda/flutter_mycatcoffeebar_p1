import '../model/md_cadastro.dart';
import '../model/md_cardapio.dart';

class DadosService {
  List<CadastroUser> users = [];
  List<Cardapio> cardapio = [];

  void adicionarUser(CadastroUser user) {
    users.add(user);
  }

  void removerUser(index) {
    users.removeAt(index);
  }

  CadastroUser retornarUser(id) {
    return users[id];
  }

  void adicionarCardapio(Cardapio item) {
    cardapio.add(item);
  }

  void removerCardapio(index) {
    cardapio.removeAt(index);
  }

  Cardapio retornarCardapio(id) {
    return cardapio[id];
  }
}
