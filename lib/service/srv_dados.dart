import '../model/md_cadastro.dart';
import '../model/md_cardapio.dart';
import '../model/md_carrinho.dart';

class DadosService {
  List<CadastroUser> users = [];
  List<Cardapio> cardapio = [];
  List<Carrinho> carrinho = [];
  double valorTotal = 0;

  void adicionarUser(CadastroUser user) {
    users.add(user);
  }

  void removerUser(index) {
    users.removeAt(index);
  }

  CadastroUser? retornarUser(email) {
    for (var emailUser in users) {
      if (emailUser.email == email) {
        return emailUser; // Usuário encontrado
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

  void adicionarCarrinho(Carrinho item) {
    carrinho.add(item);
    valorTotal = valorTotal + item.valorunit;
  }
}
