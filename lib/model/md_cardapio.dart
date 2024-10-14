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

  // Atribuindo itens do cardápio
  static List<Cardapio> preencher() {
    List<Cardapio> lista = [];

// Entradas
    lista.add(Cardapio(
        '001',
        'Pão de Queijo',
        'Fofinhos e quentinhos, recheados com queijo minas',
        'Entrada',
        8.00,
        '/lib/images/cardapio/ft_pao_de_queijo.jpg'));
    lista.add(Cardapio(
        '002',
        'Coxinha',
        'Deliciosa coxinha feita com massa leve, recheada com frango desfiado',
        'Entrada',
        6.00,
        '/lib/images/cardapio/ft_coxinha.jpg'));
    lista.add(Cardapio(
        '003',
        'Bolinho de Bacalhau',
        'Crocante por fora, macio por dentro, com sabor intenso de bacalhau',
        'Entrada',
        10.50,
        '/lib/images/cardapio/ft_bolinho_de_bacalhau.jpg'));
    lista.add(Cardapio(
        '004',
        'Torrada com Abacate',
        'Torrada crocante com abacate fresco, limão e temperos',
        'Entrada',
        12.00,
        '/lib/images/cardapio/ft_torrada_com_abacate.jpg'));
    lista.add(Cardapio(
        '005',
        'Mini Salada',
        'Salada leve de folhas verdes, tomate e molho especial',
        'Entrada',
        9.00,
        '/lib/images/cardapio/ft_mini_salad.jpg'));
    lista.add(Cardapio(
        '006',
        'Quiche',
        'Quiche de espinafre e queijo, assada até ficar dourada',
        'Entrada',
        15.00,
        '/lib/images/cardapio/ft_quiche.jpg'));
    lista.add(Cardapio(
        '007',
        'Salada Caesar',
        'Clássica salada Caesar com frango grelhado e crocantes croutons',
        'Entrada',
        22.50,
        '/lib/images/cardapio/ft_salad_caesar.jpg'));
    lista.add(Cardapio(
        '008',
        'Nachos',
        'Tortilhas crocantes com guacamole, salsa e queijo derretido',
        'Entrada',
        12.50,
        '/lib/images/cardapio/ft_nachos.jpg'));
    lista.add(Cardapio(
        '009',
        'Tapioca',
        'Tapioca recheada com queijo e presunto, uma combinação irresistível',
        'Entrada',
        12.00,
        '/lib/images/cardapio/ft_tapioca.jpg'));
    lista.add(Cardapio(
        '010',
        'Bruschetta',
        'Fatias de pão italiano cobertas com tomate fresco, manjericão e azeite',
        'Entrada',
        10.00,
        '/lib/images/cardapio/ft_bruschetta.jpg'));

// Pratos Principais
    lista.add(Cardapio(
        '011',
        'Esfiha',
        'Esfiha recheada com carne temperada, assada na perfeição',
        'Prato Principal',
        15.00,
        '/lib/images/cardapio/ft_esfiha.jpg'));
    lista.add(Cardapio(
        '012',
        'Hambúrguer Artesanal',
        'Suculento hambúrguer de carne com queijo, bacon e molhos especiais',
        'Prato Principal',
        22.00,
        '/lib/images/cardapio/ft_hamburguer_artesanal.jpg'));
    lista.add(Cardapio(
        '013',
        'Pizza de Calabresa',
        'Pizza crocante coberta com calabresa fatiada e cebola',
        'Prato Principal',
        36.00,
        '/lib/images/cardapio/ft_pizza_calabresa.jpg'));
    lista.add(Cardapio(
        '014',
        'Prato de Feijoada',
        'Feijoada completa com arroz, farofa e laranja',
        'Prato Principal',
        30.00,
        '/lib/images/cardapio/ft_feijoada.jpg'));
    lista.add(Cardapio(
        '015',
        'Frango Grelhado',
        'Peito de frango grelhado servido com legumes sazonais',
        'Prato Principal',
        25.00,
        '/lib/images/cardapio/ft_frango_grelhado.jpg'));
    lista.add(Cardapio(
        '016',
        'Lasanha',
        'Camadas de massa com carne moída e queijo gratinado',
        'Prato Principal',
        32.00,
        '/lib/images/cardapio/ft_lasanha.jpg'));
    lista.add(Cardapio(
        '017',
        'Bife Acebolado',
        'Bife macio acebolado, acompanhado de arroz e batata-frita',
        'Prato Principal',
        35.00,
        '/lib/images/cardapio/ft_bife_acebolado.jpg'));
    lista.add(Cardapio(
        '018',
        'Pizza Margherita',
        'Pizza clássica com molho de tomate, mozzarella e manjericão',
        'Prato Principal',
        34.90,
        '/lib/images/cardapio/ft_pizza_margherita.jpg'));
    lista.add(Cardapio(
        '019',
        'Burguer Vegano',
        'Hambúrguer feito com legumes frescos e grãos',
        'Prato Principal',
        20.00,
        '/lib/images/cardapio/ft_burguer_vegano.jpg'));

// Doces
    lista.add(Cardapio(
        '020',
        'Bolo de Chocolate',
        'Bolo fofo de chocolate coberto com ganache cremoso',
        'Doce',
        14.00,
        '/lib/images/cardapio/ft_bolo_de_chocolate.jpg'));
    lista.add(Cardapio(
        '021',
        'Bolo de Cenoura',
        'Bolo de cenoura fofinho com cobertura de chocolate',
        'Doce',
        14.00,
        '/lib/images/cardapio/ft_bolo_de_cenoura.jpg'));
    lista.add(Cardapio(
        '022',
        'Bolo de Coco',
        'Bolo de coco molhadinho com cobertura de coco ralado',
        'Doce',
        13.00,
        '/lib/images/cardapio/ft_bolo_de_coco.jpg'));
    lista.add(Cardapio(
        '023',
        'Bolo de Limão',
        'Bolo leve de limão com calda cítrica',
        'Doce',
        12.50,
        '/lib/images/cardapio/ft_bolo_de_limao.jpg'));
    lista.add(Cardapio(
        '024',
        'Bolo de Fubá',
        'Tradicional bolo de fubá, macio e saboroso',
        'Doce',
        11.00,
        '/lib/images/cardapio/ft_bolo_de_fuba.jpg'));
    lista.add(Cardapio(
        '025',
        'Bolo de Morango',
        'Bolo de morango com recheio cremoso de chantilly',
        'Doce',
        15.00,
        '/lib/images/cardapio/ft_bolo_de_morango.jpg'));
    lista.add(Cardapio(
        '026',
        'Torta de Limão',
        'Torta leve de limão com merengue dourado',
        'Doce',
        15.50,
        '/lib/images/cardapio/ft_torta_de_limao.jpg'));
    lista.add(Cardapio(
        '027',
        'Pudim',
        'Clássico pudim de leite condensado, irresistivelmente cremoso',
        'Doce',
        9.00,
        '/lib/images/cardapio/ft_pudim.jpg'));
    lista.add(Cardapio(
        '028',
        'Bolo de Rolo',
        'Delicioso bolo de rolo tradicional, recheado com goiabada',
        'Doce',
        12.00,
        '/lib/images/cardapio/ft_bolo_de_rolo.jpg'));
    lista.add(Cardapio(
        '029',
        'Brigadeiro',
        'Docinho de leite condensado enrolado e coberto com granulado',
        'Doce',
        3.50,
        '/lib/images/cardapio/ft_brigadeiro.jpg'));
    lista.add(Cardapio(
        '030',
        'Pavê de Chocolate',
        'Camadas de biscoitos e chocolate, com sabor de infância',
        'Doce',
        13.00,
        '/lib/images/cardapio/ft_pave_de_chocolate.jpg'));
    lista.add(Cardapio(
        '031',
        'Mousse de Maracujá',
        'Mousse leve e refrescante de maracujá',
        'Doce',
        11.00,
        '/lib/images/cardapio/ft_mousse_de_maracuja.jpg'));
    lista.add(Cardapio(
        '032',
        'Brownie',
        'Brownie de chocolate com pedaços de nozes, irresistível',
        'Doce',
        10.00,
        '/lib/images/cardapio/ft_brownie.jpg'));
    lista.add(Cardapio(
        '033',
        'Pudim de Chocolate',
        'Pudim de chocolate com calda de caramelo',
        'Doce',
        11.00,
        '/lib/images/cardapio/ft_pudim_de_chocolate.jpg'));
    lista.add(Cardapio(
        '034',
        'Gelatina Colorida',
        'Gelatina fresca com pedaços de frutas variadas',
        'Doce',
        5.00,
        '/lib/images/cardapio/ft_gelatina_colorida.jpg'));
    lista.add(Cardapio(
        '035',
        'Churros',
        'Churros crocantes recheados com doce de leite',
        'Doce',
        6.00,
        '/lib/images/cardapio/ft_churros.jpg'));
    lista.add(Cardapio(
        '036',
        'Pão de Mel',
        'Pão de mel coberto com chocolate e recheado com doce de leite',
        'Doce',
        8.00,
        '/lib/images/cardapio/ft_pao_de_mel.jpg'));
    lista.add(Cardapio(
        '037',
        'Biscoitos',
        'Biscoitos caseiros, crocantes e saborosos',
        'Doce',
        5.00,
        '/lib/images/cardapio/ft_biscoitos.jpg'));

// Bebidas
    lista.add(Cardapio(
        '038',
        'Chá Gelado',
        'Chá gelado refrescante, perfeito para dias quentes',
        'Bebidas',
        5.00,
        '/lib/images/cardapio/ft_cha_gelado.jpg'));
    lista.add(Cardapio(
        '039',
        'Suco Natural',
        'Suco de laranja fresco e natural, sem conservantes',
        'Bebidas',
        6.00,
        '/lib/images/cardapio/ft_suco_natural.jpg'));
    lista.add(Cardapio(
        '040',
        'Refrigerante',
        'Refrigerante em lata, várias opções disponíveis',
        'Bebidas',
        5.50,
        '/lib/images/cardapio/ft_refrigerante.jpg'));
    lista.add(Cardapio(
        '041',
        'Água Mineral',
        'Água mineral sem gás, sempre refrescante',
        'Bebidas',
        3.00,
        '/lib/images/cardapio/ft_agua_mineral.jpg'));
    lista.add(Cardapio(
        '042',
        'Limonada',
        'Limonada fresca e gelada, com sabor cítrico intenso',
        'Bebidas',
        6.50,
        '/lib/images/cardapio/ft_limonada.jpg'));
    lista.add(Cardapio(
        '043',
        'Água de Coco',
        'Água de coco natural, refrescante e saudável',
        'Bebidas',
        7.00,
        '/lib/images/cardapio/ft_agua_de_coco.jpg'));
    lista.add(Cardapio(
        '044',
        'Smoothie de Frutas',
        'Smoothie cremoso de frutas frescas, delicioso e nutritivo',
        'Bebidas',
        8.00,
        '/lib/images/cardapio/ft_smoothie_frutas.jpg'));
    lista.add(Cardapio(
        '045',
        'Café',
        'Café expresso de alta qualidade, servido puro',
        'Bebidas',
        4.00,
        '/lib/images/cardapio/ft_cafe.jpg'));
    lista.add(Cardapio(
        '046',
        'Capuccino',
        'Capuccino cremoso, com espuma de leite e chocolate',
        'Bebidas',
        6.00,
        '/lib/images/cardapio/ft_capuccino.jpg'));
    lista.add(Cardapio(
        '047',
        'Frapê de Café',
        'Frapê gelado de café, uma explosão de sabor',
        'Bebidas',
        7.50,
        '/lib/images/cardapio/ft_frapê_cafe.jpg'));
    lista.add(Cardapio(
        '048',
        'Café com Leite',
        'Café filtrado com leite cremoso, no ponto certo',
        'Bebidas',
        5.00,
        '/lib/images/cardapio/ft_cafe_com_leite.jpg'));
    lista.add(Cardapio(
        '049',
        'Chá de Camomila',
        'Chá relaxante de camomila, ideal para acalmar',
        'Bebidas',
        5.00,
        '/lib/images/cardapio/ft_cha_camonila.jpg'));
    lista.add(Cardapio(
        '050',
        'Chá Preto',
        'Chá preto com um toque de limão, revigorante',
        'Bebidas',
        4.50,
        '/lib/images/cardapio/ft_cha_preto.jpg'));
    lista.add(Cardapio(
        '051',
        'Chocolate Quente',
        'Delicioso chocolate quente cremoso, um abraço em forma de bebida',
        'Bebidas',
        8.00,
        '/lib/images/cardapio/ft_chocolate_quente.jpg'));
    lista.add(Cardapio(
        '052',
        'Cappuccino',
        'Cappuccino com espuma de leite e toque de canela',
        'Bebidas',
        6.50,
        '/lib/images/cardapio/ft_cappuccino.jpg'));
    lista.add(Cardapio(
        '053',
        'Latte',
        'Café latte com leite vaporizado e um leve toque de baunilha',
        'Bebidas',
        7.00,
        '/lib/images/cardapio/ft_latte.jpg'));
    lista.add(Cardapio(
        '054',
        'Chá de Ervas',
        'Mistura de ervas aromáticas, perfeita para aquecer o corpo',
        'Bebidas',
        5.00,
        '/lib/images/cardapio/ft_cha_ervas.jpg'));
    lista.add(Cardapio(
        '055',
        'Matcha Latte',
        'Chá verde matcha com leite cremoso, rico em antioxidantes',
        'Bebidas',
        9.00,
        '/lib/images/cardapio/ft_matcha_latte.jpg'));
    lista.add(Cardapio(
        '056',
        'Café Au Lait',
        'Café filtrado com leite quente, suavemente encorpado',
        'Bebidas',
        6.00,
        '/lib/images/cardapio/ft_cafe_au_lait.jpg'));
    lista.add(Cardapio(
        '057',
        'Grogue',
        'Bebida quente com rum e açúcar, tradicional e saborosa',
        'Bebidas',
        10.00,
        '/lib/images/cardapio/ft_grogue.jpg'));
    lista.add(Cardapio(
        '058',
        'Chá de Hortelã',
        'Chá fresco de hortelã, refrescante e digestivo',
        'Bebidas',
        4.00,
        '/lib/images/cardapio/ft_cha_hortela.jpg'));
    lista.add(Cardapio(
        '059',
        'Milkshake de Morango',
        'Milkshake cremoso de morango fresco, com calda de morango',
        'Bebidas',
        10.50,
        '/lib/images/cardapio/ft_milkshake_morango.jpg'));
    lista.add(Cardapio(
        '060',
        'Milkshake de Baunilha',
        'Milkshake clássico de baunilha, suave e delicioso',
        'Bebidas',
        9.50,
        '/lib/images/cardapio/ft_milkshake_baunilha.jpg'));
    lista.add(Cardapio(
        '061',
        'Milkshake de Ovomaltine',
        'Milkshake de chocolate com pedacinhos de Ovomaltine',
        'Bebidas',
        11.00,
        '/lib/images/cardapio/ft_milkshake_ovomaltine.jpg'));
    lista.add(Cardapio(
        '062',
        'Milkshake de Nutella',
        'Milkshake de Nutella, irresistivelmente cremoso',
        'Bebidas',
        12.00,
        '/lib/images/cardapio/ft_milkshake_nutella.jpg'));
    lista.add(Cardapio(
        '063',
        'Milkshake de Cookies',
        'Milkshake com pedaços de biscoito, uma explosão de sabor',
        'Bebidas',
        11.50,
        '/lib/images/cardapio/ft_milkshake_cookies.jpg'));
    lista.add(Cardapio(
        '064',
        'Caipirinha',
        'Clássica caipirinha feita com limão, açúcar e cachaça',
        'Bebidas',
        12.00,
        '/lib/images/cardapio/ft_caipirinha.jpg'));
    lista.add(Cardapio(
        '065',
        'Mojito',
        'Refrescante mojito com rum, hortelã e limão',
        'Bebidas',
        14.00,
        '/lib/images/cardapio/ft_mojito.jpg'));
    lista.add(Cardapio(
        '066',
        'Piña Colada',
        'Deliciosa piña colada com rum, abacaxi e creme de coco',
        'Bebidas',
        15.00,
        '/lib/images/cardapio/ft_pina_colada.jpg'));
    lista.add(Cardapio(
        '067',
        'Gin Tônica',
        'Refrescante gin tônica com limão e ervas',
        'Bebidas',
        13.00,
        '/lib/images/cardapio/ft_gin_tonica.jpg'));
    lista.add(Cardapio(
        '068',
        'Margarita',
        'Margarita clássica com tequila, limão e sal na borda',
        'Bebidas',
        14.50,
        '/lib/images/cardapio/ft_margarita.jpg'));
    lista.add(Cardapio(
        '069',
        'Cerveja Artesanal',
        'Cerveja artesanal de diversos estilos, sabor marcante',
        'Bebidas',
        12.00,
        '/lib/images/cardapio/ft_cerveja_artesanal.jpg'));
    lista.add(Cardapio(
        '070',
        'Vinho Tinto',
        'Vinho tinto encorpado, ideal para acompanhar pratos',
        'Bebidas',
        20.00,
        '/lib/images/cardapio/ft_vinho_tinto.jpg'));
    lista.add(Cardapio(
        '071',
        'Vinho Branco',
        'Vinho branco refrescante, perfeito para climas quentes',
        'Bebidas',
        20.00,
        '/lib/images/cardapio/ft_vinho_branco.jpg'));
    lista.add(Cardapio(
        '072',
        'Espumante',
        'Espumante leve e borbulhante, ideal para celebrações',
        'Bebidas',
        25.00,
        '/lib/images/cardapio/ft_espumante.jpg'));

    return lista;
  }
}
