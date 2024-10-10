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

  CadastroUser? retornarUser(email) {
    for (var email_user in users) {
      if (email_user.email == email) {
        return email_user; // Usuário encontrado
      }
    }
    return null;
  }

  bool existeUser(email) {
    return users.contains(email);
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
