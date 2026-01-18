import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(home: AtletaScreen(jogador: mockJogadorData)));
}

// Dados fictícios do jogador
final Map<String, dynamic> mockJogadorData = {
  'nome': 'Lionel Messi',
  'nascimento': '24/06/1987',
  'nacionalidade': 'Argentina',
  'idade': 36,
  'altura': 170,
  'peso': 72,
  'numero': 10,
  'posicao_principal': 'Atacante',
  'posicoes_secundarias': ['Meia', 'Pontua'],
  'pe_preferido': 'Esquerdo',
  'foto': 'https://example.com/messi.jpg',
  'overall': 93,
  'atributos': {
    'velocidade': 85,
    'finalizacao': 95,
    'passe': 91,
    'drible': 97,
    'defesa': 35,
    'fisico': 65,
  },
  'estatisticas': {
    'jogos': 45,
    'minutos': 3850,
    'gols': 32,
    'assistencias': 18,
    'finalizacoes_por_jogo': 4.2,
    'precisao_finalizacao': 58,
    'chutes_no_gol_por_jogo': 2.1,
    'gols_cabeca': 3,
    'passes_por_jogo': 62.4,
    'precisao_passe': 86,
    'passes_chave_por_jogo': 3.5,
    'cruzamentos_por_jogo': 1.8,
    'desarmes_por_jogo': 0.7,
    'interceptacoes_por_jogo': 1.2,
    'carrinhos_por_jogo': 0.3,
    'faltas_por_jogo': 1.5,
  },
  'conquistas': {
    'titulos': [
      {'nome': 'Copa do Mundo FIFA', 'ano': '2022', 'time': 'Argentina'},
      {'nome': 'Liga dos Campeões', 'ano': '2015', 'time': 'Barcelona'},
      {'nome': 'La Liga', 'ano': '2019', 'time': 'Barcelona'},
    ],
    'premios': [
      {'nome': 'Bola de Ouro', 'ano': '2021'},
      {'nome': 'Melhor Jogador do Mundo FIFA', 'ano': '2019'},
      {'nome': 'Chuteira de Ouro', 'ano': '2018'},
    ],
  },
  'historico': {
    'clubes': [
      {
        'nome': 'Paris Saint-Germain',
        'periodo': '2021-2023',
        'jogos': 75,
        'gols': 32,
      },
      {'nome': 'Barcelona', 'periodo': '2004-2021', 'jogos': 778, 'gols': 672},
    ],
    'lesiones': [
      {'tipo': 'Lesão no joelho', 'periodo': 'Março 2022', 'dias': 21},
      {'tipo': 'Distensão muscular', 'periodo': 'Setembro 2021', 'dias': 14},
    ],
  },
};

class AtletaScreen extends StatefulWidget {
  final Map<String, dynamic> jogador;

  const AtletaScreen({Key? key, required this.jogador}) : super(key: key);

  @override
  _AtletaScreenState createState() => _AtletaScreenState();
}

class _AtletaScreenState extends State<AtletaScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late Map<String, dynamic> _jogadorEditado;
  bool _editando = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _jogadorEditado = Map.from(widget.jogador);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editando ? 'Editando Jogador' : 'Perfil do Jogador'),
        actions: [
          IconButton(
            icon: Icon(_editando ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                if (_editando) {
                  // Salvar alterações
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Alterações salvas com sucesso!')),
                  );
                }
                _editando = !_editando;
              });
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.person), text: 'Perfil'),
            Tab(icon: Icon(Icons.assessment), text: 'Estatísticas'),
            Tab(icon: Icon(Icons.emoji_events), text: 'Conquistas'),
            Tab(icon: Icon(Icons.history), text: 'Histórico'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPerfilTab(),
          _buildEstatisticasTab(),
          _buildConquistasTab(),
          _buildHistoricoTab(),
        ],
      ),
    );
  }

  Widget _buildPerfilTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Card do Jogador
          _buildPlayerCard(),
          const SizedBox(height: 24),

          // Seção de Dados Pessoais
          _buildSectionTitle('Dados Pessoais'),
          _buildEditableField(
            label: 'Nome Completo',
            value: _jogadorEditado['nome'],
            isEditing: _editando,
            onChanged: (value) => _jogadorEditado['nome'] = value,
          ),
          _buildEditableField(
            label: 'Data de Nascimento',
            value: _jogadorEditado['nascimento'],
            isEditing: _editando,
            onChanged: (value) => _jogadorEditado['nascimento'] = value,
          ),
          _buildEditableField(
            label: 'Nacionalidade',
            value: _jogadorEditado['nacionalidade'],
            isEditing: _editando,
            onChanged: (value) => _jogadorEditado['nacionalidade'] = value,
          ),
          _buildEditableField(
            label: 'Altura (cm)',
            value: _jogadorEditado['altura'].toString(),
            isEditing: _editando,
            onChanged: (value) => _jogadorEditado['altura'] =
                int.tryParse(value) ?? _jogadorEditado['altura'],
          ),
          _buildEditableField(
            label: 'Peso (kg)',
            value: _jogadorEditado['peso'].toString(),
            isEditing: _editando,
            onChanged: (value) => _jogadorEditado['peso'] =
                int.tryParse(value) ?? _jogadorEditado['peso'],
          ),

          // Seção de Características
          const SizedBox(height: 24),
          _buildSectionTitle('Características'),
          _buildEditableDropdown(
            label: 'Posição Principal',
            value: _jogadorEditado['posicao_principal'],
            items: const [
              'Goleiro',
              'Zagueiro',
              'Lateral',
              'Volante',
              'Meia',
              'Atacante',
            ],
            isEditing: _editando,
            onChanged: (value) => _jogadorEditado['posicao_principal'] = value,
          ),
          _buildEditableDropdown(
            label: 'Posições Secundárias',
            value: _jogadorEditado['posicoes_secundarias'],
            items: const [
              'Goleiro',
              'Zagueiro',
              'Lateral',
              'Volante',
              'Meia',
              'Atacante',
            ],
            isEditing: _editando,
            onChanged: (value) =>
                _jogadorEditado['posicoes_secundarias'] = value,
            multiple: true,
          ),
          _buildEditableDropdown(
            label: 'Pé Preferido',
            value: _jogadorEditado['pe_preferido'],
            items: const ['Direito', 'Esquerdo', 'Ambos'],
            isEditing: _editando,
            onChanged: (value) => _jogadorEditado['pe_preferido'] = value,
          ),

          // Seção de Atributos
          if (!_editando) ...[
            const SizedBox(height: 24),
            _buildSectionTitle('Atributos'),
            _buildAttributeRow(
              'Velocidade',
              _jogadorEditado['atributos']['velocidade'],
            ),
            _buildAttributeRow(
              'Finalização',
              _jogadorEditado['atributos']['finalizacao'],
            ),
            _buildAttributeRow('Passe', _jogadorEditado['atributos']['passe']),
            _buildAttributeRow(
              'Drible',
              _jogadorEditado['atributos']['drible'],
            ),
            _buildAttributeRow(
              'Defesa',
              _jogadorEditado['atributos']['defesa'],
            ),
            _buildAttributeRow(
              'Físico',
              _jogadorEditado['atributos']['fisico'],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildEstatisticasTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Estatísticas Gerais
          _buildSectionTitle('Estatísticas da Temporada'),
          _buildStatCard(
            title: 'Desempenho Geral',
            stats: {
              'Jogos': _jogadorEditado['estatisticas']['jogos'],
              'Minutos': _jogadorEditado['estatisticas']['minutos'],
              'Gols': _jogadorEditado['estatisticas']['gols'],
              'Assistências': _jogadorEditado['estatisticas']['assistencias'],
            },
            editable: _editando,
          ),

          // Estatísticas Detalhadas
          const SizedBox(height: 16),
          _buildSectionTitle('Detalhes Ofensivos'),
          _buildStatCard(
            title: 'Ataque',
            stats: {
              'Finalizações pg':
                  _jogadorEditado['estatisticas']['finalizacoes_por_jogo'],
              'Precisão de Finalização':
                  '${_jogadorEditado['estatisticas']['precisao_finalizacao']}%',
              'Chutes no Gol pg':
                  _jogadorEditado['estatisticas']['chutes_no_gol_por_jogo'],
              'Gols de Cabeça': _jogadorEditado['estatisticas']['gols_cabeca'],
            },
            editable: _editando,
          ),

          const SizedBox(height: 16),
          _buildSectionTitle('Detalhes de Passe'),
          _buildStatCard(
            title: 'Criação de Jogo',
            stats: {
              'Passes pg': _jogadorEditado['estatisticas']['passes_por_jogo'],
              'Precisão de Passe':
                  '${_jogadorEditado['estatisticas']['precisao_passe']}%',
              'Passes Chave pg':
                  _jogadorEditado['estatisticas']['passes_chave_por_jogo'],
              'Cruzamentos pg':
                  _jogadorEditado['estatisticas']['cruzamentos_por_jogo'],
            },
            editable: _editando,
          ),

          if (_jogadorEditado['posicao_principal'] == 'Zagueiro' ||
              _jogadorEditado['posicao_principal'] == 'Lateral' ||
              _jogadorEditado['posicao_principal'] == 'Volante') ...[
            const SizedBox(height: 16),
            _buildSectionTitle('Detalhes Defensivos'),
            _buildStatCard(
              title: 'Defesa',
              stats: {
                'Desarmes pg':
                    _jogadorEditado['estatisticas']['desarmes_por_jogo'],
                'Interceptações pg':
                    _jogadorEditado['estatisticas']['interceptacoes_por_jogo'],
                'Carrinhos pg':
                    _jogadorEditado['estatisticas']['carrinhos_por_jogo'],
                'Faltas pg': _jogadorEditado['estatisticas']['faltas_por_jogo'],
              },
              editable: _editando,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildConquistasTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Títulos Coletivos'),
          ..._jogadorEditado['conquistas']['titulos']
              .map<Widget>(
                (titulo) => _buildTrophyItem(
                  titulo['nome'],
                  titulo['ano'],
                  titulo['time'],
                ),
              )
              .toList(),

          const SizedBox(height: 24),
          _buildSectionTitle('Prêmios Individuais'),
          ..._jogadorEditado['conquistas']['premios']
              .map<Widget>(
                (premio) => _buildAwardItem(premio['nome'], premio['ano']),
              )
              .toList(),

          if (_editando) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _showAddAchievementDialog(),
              child: const Text('Adicionar Conquista'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildHistoricoTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('Histórico de Clubes'),
          ..._jogadorEditado['historico']['clubes']
              .map<Widget>(
                (clube) => _buildClubHistoryItem(
                  clube['nome'],
                  clube['periodo'],
                  clube['jogos'],
                  clube['gols'],
                ),
              )
              .toList(),

          const SizedBox(height: 24),
          _buildSectionTitle('Histórico de Lesões'),
          if (_jogadorEditado['historico']['lesiones'].isEmpty)
            const Text('Nenhuma lesão registrada'),
          ..._jogadorEditado['historico']['lesiones']
              .map<Widget>(
                (lesao) => _buildInjuryItem(
                  lesao['tipo'],
                  lesao['periodo'],
                  lesao['dias'],
                ),
              )
              .toList(),

          if (_editando) ...[
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => _showAddHistoryDialog(),
              child: const Text('Adicionar Item ao Histórico'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPlayerCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, size: 50, color: Colors.grey),
                ),
                if (_editando)
                  IconButton(
                    icon: const Icon(Icons.camera_alt, size: 20),
                    onPressed: _changePlayerPhoto,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              _jogadorEditado['nome'],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _jogadorEditado['posicao_principal'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Nº ${_jogadorEditado['numero']}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (_editando) ...[
              TextFormField(
                initialValue: _jogadorEditado['numero'].toString(),
                decoration: const InputDecoration(
                  labelText: 'Número da Camisa',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _jogadorEditado['numero'] =
                        int.tryParse(value) ?? _jogadorEditado['numero'];
                  });
                },
              ),
            ],
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text(
                      'AR',
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _jogadorEditado['nacionalidade'],
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${_jogadorEditado['idade']} anos | ${_jogadorEditado['altura']} cm | ${_jogadorEditado['peso']} kg',
              style: const TextStyle(color: Colors.grey),
            ),
            if (!_editando) ...[
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: _jogadorEditado['overall'] / 100,
                backgroundColor: Colors.grey[200],
                valueColor: AlwaysStoppedAnimation<Color>(
                  _getOverallColor(_jogadorEditado['overall']),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Overall: ${_jogadorEditado['overall']}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required bool isEditing,
    required Function(String) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isEditing
          ? TextFormField(
              initialValue: value,
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
              ),
              onChanged: onChanged,
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(value)),
              ],
            ),
    );
  }

  Widget _buildEditableDropdown({
    required String label,
    required dynamic value,
    required List<String> items,
    required bool isEditing,
    required Function(dynamic) onChanged,
    bool multiple = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: isEditing
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                multiple
                    ? MultiSelectChipField(
                        items: items
                            .map((item) => MultiSelectItem(item, item))
                            .toList(),
                        initialValue: value.cast<String>(),
                        onTap: (selectedItems) => onChanged(selectedItems),
                      )
                    : DropdownButtonFormField<String>(
                        value: value,
                        items: items.map((item) {
                          return DropdownMenuItem<String>(
                            value: item,
                            child: Text(item),
                          );
                        }).toList(),
                        onChanged: onChanged,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 150,
                  child: Text(
                    label,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    multiple ? (value as List).join(', ') : value.toString(),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildAttributeRow(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(width: 120, child: Text(label)),
          Expanded(
            child: LinearProgressIndicator(
              value: value / 100,
              backgroundColor: Colors.grey[200],
              valueColor: AlwaysStoppedAnimation<Color>(
                _getAttributeColor(value),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text('$value'),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required Map<String, dynamic> stats,
    required bool editable,
  }) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            ...stats.entries.map<Widget>((entry) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  children: [
                    SizedBox(width: 150, child: Text(entry.key)),
                    if (editable)
                      Expanded(
                        child: TextFormField(
                          initialValue: entry.value.toString(),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            // Atualizar estatística
                          },
                        ),
                      )
                    else
                      Text(
                        entry.value.toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildTrophyItem(String nome, String ano, String time) {
    return ListTile(
      leading: const Icon(Icons.emoji_events, color: Colors.amber),
      title: Text(nome),
      subtitle: Text('$ano - $time'),
      trailing: _editando
          ? IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Remover título
              },
            )
          : null,
    );
  }

  Widget _buildAwardItem(String nome, String ano) {
    return ListTile(
      leading: const Icon(Icons.star, color: Colors.blue),
      title: Text(nome),
      subtitle: Text(ano),
      trailing: _editando
          ? IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                // Remover prêmio
              },
            )
          : null,
    );
  }

  Widget _buildClubHistoryItem(
    String nome,
    String periodo,
    int jogos,
    int gols,
  ) {
    return ListTile(
      leading: const Icon(Icons.group, color: Colors.green),
      title: Text(nome),
      subtitle: Text(periodo),
      trailing: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [Text('$jogos jogos'), Text('$gols gols')],
      ),
    );
  }

  Widget _buildInjuryItem(String tipo, String periodo, int dias) {
    return ListTile(
      leading: const Icon(Icons.healing, color: Colors.red),
      title: Text(tipo),
      subtitle: Text('$periodo ($dias dias)'),
    );
  }

  Color _getOverallColor(int overall) {
    if (overall >= 90) return Colors.purple;
    if (overall >= 80) return Colors.red;
    if (overall >= 70) return Colors.orange;
    if (overall >= 60) return Colors.yellow[700]!;
    return Colors.green;
  }

  Color _getAttributeColor(int value) {
    if (value >= 90) return Colors.purple;
    if (value >= 80) return Colors.red;
    if (value >= 70) return Colors.orange;
    if (value >= 60) return Colors.yellow[700]!;
    if (value >= 50) return Colors.green;
    return Colors.blue;
  }

  void _changePlayerPhoto() {
    // Implementar lógica para alterar foto
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alterar Foto'),
        content: const Text('Escolha uma nova foto para o jogador'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Simular mudança de foto
              setState(() {
                _jogadorEditado['foto'] = 'https://example.com/new_photo.jpg';
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Foto alterada com sucesso!')),
              );
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  void _showAddAchievementDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar Conquista'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Título/Prêmio'),
            ),
            TextFormField(decoration: const InputDecoration(labelText: 'Ano')),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Time (se aplicável)',
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Adicionar conquista fictícia
              setState(() {
                _jogadorEditado['conquistas']['titulos'].add({
                  'nome': 'Novo Título',
                  'ano': '2023',
                  'time': 'Novo Time',
                });
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Conquista adicionada!')),
              );
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }

  void _showAddHistoryDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar ao Histórico'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Tipo (Clube/Lesão)',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Período'),
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Detalhes'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              // Adicionar item fictício ao histórico
              setState(() {
                _jogadorEditado['historico']['clubes'].add({
                  'nome': 'Novo Clube',
                  'periodo': '2023-2024',
                  'jogos': 0,
                  'gols': 0,
                });
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Item adicionado ao histórico!')),
              );
            },
            child: const Text('Adicionar'),
          ),
        ],
      ),
    );
  }
}

// Widget auxiliar para seleção múltipla
class MultiSelectChipField extends StatefulWidget {
  final List<MultiSelectItem> items;
  final List<String> initialValue;
  final Function(List<String>) onTap;

  const MultiSelectChipField({
    Key? key,
    required this.items,
    required this.initialValue,
    required this.onTap,
  }) : super(key: key);

  @override
  _MultiSelectChipFieldState createState() => _MultiSelectChipFieldState();
}

class _MultiSelectChipFieldState extends State<MultiSelectChipField> {
  late List<String> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List.from(widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      children: widget.items.map((item) {
        return FilterChip(
          label: Text(item.label),
          selected: _selectedItems.contains(item.value),
          onSelected: (selected) {
            setState(() {
              if (selected) {
                _selectedItems.add(item.value);
              } else {
                _selectedItems.remove(item.value);
              }
              widget.onTap(_selectedItems);
            });
          },
        );
      }).toList(),
    );
  }
}

class MultiSelectItem {
  final String value;
  final String label;

  MultiSelectItem(this.value, this.label);
}
