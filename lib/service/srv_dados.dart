import '../model/md_cadastro.dart';
import '../model/md_cardapio.dart';
import '../model/md_carrinho.dart';

class DadosService {
  List<CadastroUser> users = [];
  List<Cardapio> cardapio = [];
  List<Carrinho> carrinho = [];
  double valorTotal = 0;

  // FUNÇÕES PARA OS USUÁRIOS
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

  int? obterIndexPorEmail(String email) {
    for (int i = 0; i < users.length; i++) {
      if (users[i].email == email) {
        return i;
      }
    }
    return null;
  }

  bool existeUser(email) {
    return users.any((user) => user.email == email);
  }

  // FUNÇÕES PARA O CARDÁPIO
  void preencherCardapio() {
    Cardapio.preencher();
  }

  void adicionarCardapio(Cardapio item) {
    cardapio.add(item);
  }

  Cardapio retornarCardapio(id) {
    return cardapio[id];
  }

  // FUNÇÕES PARA O CARRINHO DE PEDIDO
  int? obterIndexItem(String codigo) {
    for (int i = 0; i < carrinho.length; i++) {
      if (carrinho[i].codigo == codigo) {
        return i;
      }
    }
    return null;
  }

  void adicionarCarrinho(Carrinho item) {
    var index = obterIndexItem(item.codigo);
    if (index == null) {
      item.valorTotalItm = item.valorunit;
      carrinho.add(item);
    } else {
      carrinho[index].quantidade = carrinho[index].quantidade + 1;
      carrinho[index].valorTotalItm =
          carrinho[index].valorunit * carrinho[index].quantidade;
    }
    valorTotal = valorTotal + item.valorunit;
  }

  void removerUnidCarrinho(index) {
    if (carrinho[index].quantidade == 1) {
      removerItmCarrinho(index);
    } else {
      carrinho[index].quantidade = carrinho[index].quantidade - 1;
      carrinho[index].valorTotalItm =
          carrinho[index].valorunit * carrinho[index].quantidade;
    }
  }

  void removerItmCarrinho(index) {
    carrinho.removeAt(index);
  }
}
