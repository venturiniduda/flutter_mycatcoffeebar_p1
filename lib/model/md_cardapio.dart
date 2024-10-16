import 'package:flutter_mycatcoffeebar_p1/service/srv_dados.dart';
import 'package:get_it/get_it.dart';

final DadosService srv = GetIt.instance<DadosService>();

class Cardapio {
  final String codigo;
  final String nome;
  final String descricao;
  final String categoria;
  final double valor;
  final String imagem;

  // Construtor
  Cardapio(
    this.codigo,
    this.nome,
    this.descricao,
    this.categoria,
    this.valor,
    this.imagem,
  );

  static preencher() {
    // Atribuindo itens do cardápio
    // Entradas
    srv.adicionarCardapio(Cardapio(
        '001',
        'Pão de Queijo',
        'Fofinhos e quentinhos, recheados com queijo minas.',
        'Entrada',
        8.00,
        'lib/images/cardapio/ftpaodequeijo.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '002',
        'Coxinha',
        'Deliciosa coxinha feita com massa leve, recheada com frango desfiado.',
        'Entrada',
        6.00,
        'lib/images/cardapio/ftcoxinha.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '003',
        'Bolinho de Bacalhau',
        'Crocante por fora, macio por dentro, com sabor intenso de bacalhau.',
        'Entrada',
        10.50,
        'lib/images/cardapio/ftbolinhodebacalhau.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '004',
        'Torrada com Abacate',
        'Torrada crocante com abacate fresco, limão e temperos.',
        'Entrada',
        12.00,
        'lib/images/cardapio/fttorradacomabacate.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '005',
        'Mini Salada',
        'Salada leve de folhas verdes, tomate e molho especial.',
        'Entrada',
        9.00,
        'lib/images/cardapio/ftminisalada.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '006',
        'Quiche',
        'Quiche de espinafre e queijo, assada até ficar dourada.',
        'Entrada',
        15.00,
        'lib/images/cardapio/ftquiche.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '007',
        'Salada Caesar',
        'Clássica salada Caesar com frango grelhado e crocantes croutons.',
        'Entrada',
        22.50,
        'lib/images/cardapio/ftsaladcaesar.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '008',
        'Nachos',
        'Tortilhas crocantes com guacamole, salsa e queijo derretido.',
        'Entrada',
        12.50,
        'lib/images/cardapio/ftnachos.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '009',
        'Tapioca',
        'Tapioca recheada com queijo e presunto, uma combinação irresistível.',
        'Entrada',
        12.00,
        'lib/images/cardapio/fttapioca.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '010',
        'Bruschetta',
        'Fatias de pão italiano cobertas com tomate fresco, manjericão e azeite.',
        'Entrada',
        10.00,
        'lib/images/cardapio/ftbruschetta.jpeg'));

// Pratos Principais
    srv.adicionarCardapio(Cardapio(
        '011',
        'Esfiha',
        'Esfiha recheada com carne temperada, assada na perfeição.',
        'Prato Principal',
        15.00,
        'lib/images/cardapio/ftesfiha.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '012',
        'Hambúrguer Artesanal',
        'Suculento hambúrguer de carne com queijo, bacon e molhos especiais.',
        'Prato Principal',
        22.00,
        'lib/images/cardapio/fthamburguerartesanal.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '013',
        'Pizza de Calabresa',
        'Pizza crocante coberta com calabresa fatiada e cebola.',
        'Prato Principal',
        36.00,
        'lib/images/cardapio/ftpizzacalabresa.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '015',
        'Frango Grelhado',
        'Peito de frango grelhado servido com legumes sazonais.',
        'Prato Principal',
        25.00,
        'lib/images/cardapio/ftfrangogrelhado.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '016',
        'Lasanha',
        'Camadas de massa com carne moída e queijo gratinado.',
        'Prato Principal',
        32.00,
        'lib/images/cardapio/ftlasanha.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '017',
        'Bife Acebolado',
        'Bife macio acebolado, acompanhado de arroz e batata-frita.',
        'Prato Principal',
        35.00,
        'lib/images/cardapio/ftbifeacebolado.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '018',
        'Pizza Margherita',
        'Pizza clássica com molho de tomate, mozzarella e manjericão.',
        'Prato Principal',
        34.90,
        'lib/images/cardapio/ftpizzamargherita.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '019',
        'Burguer Vegano',
        'Hambúrguer feito com legumes frescos e grãos.',
        'Prato Principal',
        20.00,
        'lib/images/cardapio/ftburguervegano.jpeg'));

// Doces
    srv.adicionarCardapio(Cardapio(
        '020',
        'Bolo de Chocolate',
        'Bolo fofo de chocolate coberto com ganache cremoso.',
        'Doce',
        14.00,
        'lib/images/cardapio/ftbolodechocolate.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '021',
        'Bolo de Cenoura',
        'Bolo de cenoura fofinho com cobertura de chocolate.',
        'Doce',
        14.00,
        'lib/images/cardapio/ftbolodecenoura.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '022',
        'Bolo de Coco',
        'Bolo de coco molhadinho com cobertura de coco ralado.',
        'Doce',
        13.00,
        'lib/images/cardapio/ftbolodecoco.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '023',
        'Bolo de Limão',
        'Bolo leve de limão com calda cítrica.',
        'Doce',
        12.50,
        'lib/images/cardapio/ftbolodelimao.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '024',
        'Bolo de Fubá',
        'Tradicional bolo de fubá, macio e saboroso.',
        'Doce',
        11.00,
        'lib/images/cardapio/ftbolodefuba.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '025',
        'Bolo de Morango',
        'Bolo de morango com recheio cremoso de chantilly.',
        'Doce',
        15.00,
        'lib/images/cardapio/ftbolomorango.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '026',
        'Torta de Limão',
        'Torta leve de limão com merengue dourado.',
        'Doce',
        15.50,
        'lib/images/cardapio/fttortadelimao.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '027',
        'Pudim',
        'Clássico pudim de leite condensado, irresistivelmente cremoso.',
        'Doce',
        9.00,
        'lib/images/cardapio/ftpudim.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '029',
        'Brigadeiro',
        'Docinho de leite condensado enrolado e coberto com granulado.',
        'Doce',
        3.50,
        'lib/images/cardapio/ftbrigadeiro.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '032',
        'Brownie',
        'Brownie de chocolate com pedaços de nozes, irresistível.',
        'Doce',
        10.00,
        'lib/images/cardapio/ftbrownie.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '033',
        'Pudim de Chocolate',
        'Pudim de chocolate com calda de caramelo.',
        'Doce',
        11.00,
        'lib/images/cardapio/ftpudimdechocolate.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '036',
        'Pão de Mel',
        'Pão de mel coberto com chocolate e recheado com doce de leite.',
        'Doce',
        8.00,
        'lib/images/cardapio/ftpãodamel.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '037',
        'Cookies',
        'Cookies caseiros, crocantes e saborosos.',
        'Doce',
        5.00,
        'lib/images/cardapio/ftcookies.jpeg'));

// Bebidas
    srv.adicionarCardapio(Cardapio(
        '038',
        'Chá Gelado',
        'Chá gelado refrescante, perfeito para dias quentes.',
        'Bebidas',
        5.00,
        'lib/images/cardapio/ftchagelado.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '039',
        'Suco Natural',
        'Suco de laranja fresco e natural, sem conservantes.',
        'Bebidas',
        6.00,
        'lib/images/cardapio/ftsuconatural.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '040',
        'Refrigerante',
        'Refrigerante em lata, várias opções disponíveis.',
        'Bebidas',
        5.50,
        'lib/images/cardapio/ftrefrigerante.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '041',
        'Água Mineral',
        'Água mineral sem gás, sempre refrescante.',
        'Bebidas',
        3.00,
        'lib/images/cardapio/ftaguamineral.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '045',
        'Café',
        'Café expresso de alta qualidade, servido puro.',
        'Bebidas',
        4.00,
        'lib/images/cardapio/ftcafe.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '046',
        'Capuccino',
        'Capuccino cremoso, com espuma de leite e chocolate.',
        'Bebidas',
        6.00,
        'lib/images/cardapio/ftcapuccino.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '047',
        'Frapê de Café',
        'Frapê gelado de café, uma explosão de sabor.',
        'Bebidas',
        7.50,
        'lib/images/cardapio/ftfrapecafe.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '048',
        'Café com Leite',
        'Café filtrado com leite cremoso, no ponto certo.',
        'Bebidas',
        5.00,
        'lib/images/cardapio/ftcafekomleite.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '050',
        'Chá Preto',
        'Chá preto com um toque de limão, revigorante.',
        'Bebidas',
        4.50,
        'lib/images/cardapio/ftchapreto.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '051',
        'Chocolate Quente',
        'Delicioso chocolate quente cremoso, um abraço em forma de bebida.',
        'Bebidas',
        8.00,
        'lib/images/cardapio/ftchocolatequente.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '052',
        'Cappuccino',
        'Cappuccino com espuma de leite e toque de canela.',
        'Bebidas',
        6.50,
        'lib/images/cardapio/ftcappuccino.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '053',
        'Latte',
        'Café latte com leite vaporizado e um leve toque de baunilha.',
        'Bebidas',
        7.00,
        'lib/images/cardapio/ftlatte.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '058',
        'Chá de Hortelã',
        'Chá fresco de hortelã, refrescante e digestivo.',
        'Bebidas',
        4.00,
        'lib/images/cardapio/ftchahortela.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '059',
        'Milkshake de Morango',
        'Milkshake cremoso de morango fresco, com calda de morango.',
        'Bebidas',
        10.50,
        'lib/images/cardapio/ftmilkshakemorango.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '060',
        'Milkshake de Baunilha',
        'Milkshake clássico de baunilha, suave e delicioso.',
        'Bebidas',
        9.50,
        'lib/images/cardapio/ftmilkshakebaunilha.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '061',
        'Milkshake de Ovomaltine',
        'Milkshake de chocolate com pedacinhos de Ovomaltine.',
        'Bebidas',
        11.00,
        'lib/images/cardapio/ftmilkshakeovomaltine.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '062',
        'Milkshake de Nutella',
        'Milkshake de Nutella, irresistivelmente cremoso.',
        'Bebidas',
        12.00,
        'lib/images/cardapio/ftmilkshakenutella.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '063',
        'Milkshake de Cookies',
        'Milkshake com pedaços de biscoito, uma explosão de sabor.',
        'Bebidas',
        11.50,
        'lib/images/cardapio/ftmilkshakecookies.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '064',
        'Caipirinha',
        'Clássica caipirinha feita com limão, açúcar e cachaça.',
        'Bebidas',
        12.00,
        'lib/images/cardapio/ftcaipirinha.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '065',
        'Mojito',
        'Refrescante mojito com rum, hortelã e limão.',
        'Bebidas',
        14.00,
        'lib/images/cardapio/ftmojito.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '066',
        'Piña Colada',
        'Deliciosa piña colada com rum, abacaxi e creme de coco.',
        'Bebidas',
        15.00,
        'lib/images/cardapio/ftpinaColada.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '067',
        'Gin Tônica',
        'Refrescante gin tônica com limão e ervas.',
        'Bebidas',
        13.00,
        'lib/images/cardapio/ftgintonica.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '068',
        'Margarita',
        'Margarita clássica com tequila, limão e sal na borda.',
        'Bebidas',
        14.50,
        'lib/images/cardapio/ftmargarita.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '069',
        'Cerveja Artesanal',
        'Cerveja artesanal de diversos estilos, sabor marcante.',
        'Bebidas',
        12.00,
        'lib/images/cardapio/ftcervejaartesanal.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '070',
        'Vinho Tinto',
        'Vinho tinto encorpado, ideal para acompanhar pratos.',
        'Bebidas',
        20.00,
        'lib/images/cardapio/ftvinhotinto.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '071',
        'Vinho Branco',
        'Vinho branco refrescante, perfeito para climas quentes.',
        'Bebidas',
        20.00,
        'lib/images/cardapio/ftvinhobranco.jpeg'));
    srv.adicionarCardapio(Cardapio(
        '072',
        'Espumante',
        'Espumante leve e borbulhante, ideal para celebrações.',
        'Bebidas',
        25.00,
        'lib/images/cardapio/ftespumante.jpeg'));
  }
}
