class Carrinho {
  final String codigo;
  final String status;
  final String dataHora;
  final List<ItemCarrinho> itens;

  Carrinho({
    required this.codigo,
    required this.status,
    required this.dataHora,
    required this.itens,
  });

  double get valorTotalItm => 
      itens.fold(0, (total, item) => total + (item.preco * item.quantidade));

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "uid": codigo,
      "status": status,
      "data_hora": dataHora,
      "itens": itens.map((item) => item.toJson()).toList(),
    };
  }

  factory Carrinho.fromJson(Map<String, dynamic> json) {
    return Carrinho(
      codigo: json['uid'],
      status: json['status'],
      dataHora: json['data_hora'],
      itens: (json['itens'] as List<dynamic>)
          .map((itemJson) => ItemCarrinho.fromJson(itemJson))
          .toList(),
    );
  }
}

class ItemCarrinho {
  final String itemId;
  final double preco;
  late final int quantidade;

  ItemCarrinho({
    required this.itemId,
    required this.preco,
    required this.quantidade,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      "item_id": itemId,
      "preco": preco,
      "quantidade": quantidade,
    };
  }

  factory ItemCarrinho.fromJson(Map<String, dynamic> json) {
    return ItemCarrinho(
      itemId: json['item_id'],
      preco: json['preco'].toDouble(),
      quantidade: json['quantidade'],
    );
  }
}
