import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class LojaPage extends StatefulWidget {
  const LojaPage({super.key});

  @override
  State<LojaPage> createState() => _LojaPageState();
}

class _LojaPageState extends State<LojaPage> {
  int _moedas = 1000; // Saldo inicial do usuário
  int _selectedCategory = 0;
  final List<Item> _carrinho = [];

  // Categorias da loja
  final List<Categoria> _categorias = [
    Categoria(id: 0, nome: 'Todos', icone: Icons.all_inclusive),
    Categoria(id: 1, nome: 'Chuteiras', icone: Icons.sports),
    Categoria(id: 2, nome: 'Uniformes', icone: Icons.sports),
    Categoria(id: 3, nome: 'Acessórios', icone: Icons.watch),
    Categoria(id: 4, nome: 'Pacotes', icone: Icons.card_giftcard),
  ];

  // Itens da loja
  final List<Item> _itens = [
    Item(
      id: 1,
      nome: 'Chuteira Predator',
      preco: 300,
      categoria: 1,
      imagem: 'assets/card_fifa.png',
      raridade: Raridade.epico,
    ),
    Item(
      id: 2,
      nome: 'Camisa Clássica',
      preco: 150,
      categoria: 2,
      imagem: 'assets/card_fifa.png',
      raridade: Raridade.raro,
    ),
    Item(
      id: 3,
      nome: 'Pulseira de Performance',
      preco: 80,
      categoria: 3,
      imagem: 'assets/card_fifa.png',
      raridade: Raridade.comum,
    ),
    Item(
      id: 4,
      nome: 'Pacote Iniciante',
      preco: 500,
      categoria: 4,
      imagem: 'assets/card_fifa.png',
      raridade: Raridade.lendario,
    ),
    Item(
      id: 5,
      nome: 'Meião Oficial',
      preco: 60,
      categoria: 2,
      imagem: 'assets/card_fifa.png',
      raridade: Raridade.comum,
    ),
  ];

  void _comprarItem(Item item) {
    if (_moedas >= item.preco) {
      setState(() {
        _moedas -= item.preco;
        _carrinho.add(item);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${item.nome} comprado com sucesso!'),
          backgroundColor: Colors.green,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Moedas insuficientes!'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final itensFiltrados = _selectedCategory == 0
        ? _itens
        : _itens.where((item) => item.categoria == _selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja do Jogador'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
          onPressed: () {
            // Navega para o MenuPrincipal e remove todas as rotas até chegar lá
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/menu_principal',
              (Route<dynamic> route) => false,
            );
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.monetization_on, color: Colors.amber),
                const SizedBox(width: 4),
                Text(
                  _moedas.toString(),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Categorias
          SizedBox(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _categorias.length,
              itemBuilder: (context, index) {
                final categoria = _categorias[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ChoiceChip(
                    label: Text(categoria.nome),
                    selected: _selectedCategory == categoria.id,
                    onSelected: (selected) {
                      setState(() {
                        _selectedCategory = selected ? categoria.id : 0;
                      });
                    },
                    avatar: Icon(categoria.icone),
                    selectedColor: Colors.greenAccent.withOpacity(0.2),
                  ),
                );
              },
            ),
          ),

          // Itens
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: size.width > 600 ? 3 : 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemCount: itensFiltrados.length,
              itemBuilder: (context, index) {
                final item = itensFiltrados[index];
                return _buildItemCard(item);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: _carrinho.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                // Navegar para carrinho
              },
              child: Badge(
                label: Text(_carrinho.length.toString()),
                child: const Icon(Icons.shopping_cart),
              ),
            )
          : null,
    );
  }

  Widget _buildItemCard(Item item) {
    final corRaridade = _getCorRaridade(item.raridade);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Imagem do item
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(item.imagem, fit: BoxFit.cover),
                ),
              ),

              // Detalhes do item
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nome,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.monetization_on,
                          size: 16,
                          color: Colors.amber,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          item.preco.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Tag de raridade
          Positioned(
            top: 8,
            left: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: corRaridade.withOpacity(0.8),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _getNomeRaridade(item.raridade),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Botão de compra
          Positioned(
            bottom: 8,
            right: 8,
            child: IconButton(
              icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
              onPressed: () => _comprarItem(item),
              style: IconButton.styleFrom(backgroundColor: Colors.greenAccent),
            ),
          ),
        ],
      ),
    );
  }

  Color _getCorRaridade(Raridade raridade) {
    switch (raridade) {
      case Raridade.comum:
        return Colors.grey;
      case Raridade.raro:
        return Colors.blue;
      case Raridade.epico:
        return Colors.purple;
      case Raridade.lendario:
        return Colors.orange;
    }
  }

  String _getNomeRaridade(Raridade raridade) {
    return raridade.toString().split('.').last.toUpperCase();
  }
}

// Modelos
class Categoria {
  final int id;
  final String nome;
  final IconData icone;

  Categoria({required this.id, required this.nome, required this.icone});
}

enum Raridade { comum, raro, epico, lendario }

class Item {
  final int id;
  final String nome;
  final int preco;
  final int categoria;
  final String imagem;
  final Raridade raridade;

  Item({
    required this.id,
    required this.nome,
    required this.preco,
    required this.categoria,
    required this.imagem,
    required this.raridade,
  });
}
