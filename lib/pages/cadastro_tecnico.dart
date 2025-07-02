import 'package:flutter/material.dart';
import 'components/nacionalidade.dart';
import 'components/card_jogador_tecnico.dart';

class CadastroTecnicoPage extends StatefulWidget {
  const CadastroTecnicoPage({super.key});

  @override
  State<CadastroTecnicoPage> createState() => _CadastroTecnicoPageState();
}

class _CadastroTecnicoPageState extends State<CadastroTecnicoPage> {
  // Controllers
  final _nomeCtrl = TextEditingController();
  final _apelidoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final String _fotoUrl = '';

  // Dropdown/Checkbox state
  String? experiencia;
  String? disponibilidade;
  String? estado;
  String? _nacionalidade = 'BRA';

  // Estilo tático múltiplo
  final List<String> estilosTaticos = [
    "Ofensivo",
    "Defensivo",
    "Equilibrado",
    "Pressão",
    "Jogo apoiado",
    "Contra-ataque",
    "Marcaçāo baixa",
  ];
  final Set<String> estilosSelecionados = {};

  // Níveis múltiplo
  final List<String> niveis = ["Resenha", "Amador", "Avançado", "Competitivo"];
  final Set<String> niveisSelecionados = {};

  // Estados BR
  final List<String> estados = [
    "AC",
    "AL",
    "AP",
    "AM",
    "BA",
    "CE",
    "DF",
    "ES",
    "GO",
    "MA",
    "MT",
    "MS",
    "MG",
    "PA",
    "PB",
    "PR",
    "PE",
    "PI",
    "RJ",
    "RN",
    "RS",
    "RO",
    "RR",
    "SC",
    "SP",
    "SE",
    "TO",
  ];

  // Experiência e disponibilidade
  final List<String> experienciaOpcoes = [
    "Nenhuma",
    "Menos de 1 ano",
    "1-3 anos",
    "3-5 anos",
    "+5 anos",
    "Só na resenha",
  ];
  final List<String> disponibilidadeOpcoes = [
    "Muito baixa",
    "Baixa",
    "Média",
    "Alta",
    "Muito alta",
  ];

  // Validação simples
  bool _validando = false;

  void _cadastrar() {
    setState(() => _validando = true);
    // Validação mínima
    if (_nomeCtrl.text.trim().isEmpty ||
        _apelidoCtrl.text.trim().isEmpty ||
        _emailCtrl.text.trim().isEmpty ||
        experiencia == null ||
        disponibilidade == null ||
        estado == null ||
        _cidadeCtrl.text.trim().isEmpty ||
        estilosSelecionados.isEmpty ||
        niveisSelecionados.isEmpty) {
      // Erro - campos obrigatórios
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos obrigatórios!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // TODO: salvar cadastro
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Cadastro realizado com sucesso!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;
    Widget tituloSecao(String texto, IconData icone, bool isMobile) {
      return Row(
        children: [
          Icon(icone, color: const Color(0xFF00FF00), size: isMobile ? 22 : 26),
          const SizedBox(width: 8),
          Text(
            texto,
            style: TextStyle(
              color: const Color(0xFF00FF00),
              fontWeight: FontWeight.w900,
              fontSize: isMobile ? 20 : 25,
              letterSpacing: 0.3,
            ),
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 0,
              vertical: 30,
            ),
            child: Container(
              constraints: const BoxConstraints(maxWidth: 520),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // PRÉVIA DO CARD DO TÉCNICO - LOGO NO TOPO!
                  Text(
                    '',
                    style: TextStyle(
                      color: Color(0xFF00FF00),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  JogadorTecnicoCard(
                    nome: _nomeCtrl.text,
                    apelido: _apelidoCtrl.text,
                    fotoUrl: _fotoUrl ?? '',
                    nacionalidade: _nacionalidade ?? 'BRA',
                    overall: 50, // ou valor fixo
                    nivel: 0, // ou valor fixo
                    posicaoPrincipal: 'TÉC',
                    posicoesSecundarias: const [],
                    peDominante: '',
                    altura: 0,
                    peso: 0,
                    niveis: niveisSelecionados.toList(),
                    badges: [],
                    tipoPerfil: 'Técnico',
                    estilosTaticos: estilosSelecionados.toList(), // <- estilos
                    niveisQueTreina: niveisSelecionados
                        .toList(), // <- níveis que treina
                    experiencia: experiencia ?? '',
                    disponibilidade: disponibilidade ?? '',
                  ),

                  const SizedBox(height: 28),

                  Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Criar Conta Treinador',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: isMobile ? 32 : 40,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 0.9,
                            shadows: [
                              Shadow(
                                color: Colors.greenAccent.withOpacity(0.6),
                                blurRadius: 13,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 7),
                        Text(
                          'Junte-se à comunidade FUT7',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.82),
                            fontSize: isMobile ? 18 : 20,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                  _campoTexto(
                    _nomeCtrl,
                    "Nome",
                    Icons.person,
                    obrigatorio: true,
                    erro: _validando && _nomeCtrl.text.trim().isEmpty,
                  ),
                  const SizedBox(height: 20),

                  // Apelido
                  _campoTexto(
                    _apelidoCtrl,
                    "Apelido",
                    Icons.badge,
                    obrigatorio: true,
                    erro: _validando && _apelidoCtrl.text.trim().isEmpty,
                  ),
                  const SizedBox(height: 20),

                  // E-mail
                  _campoTexto(
                    _emailCtrl,
                    "E-mail",
                    Icons.email,
                    obrigatorio: true,
                    erro: _validando && _emailCtrl.text.trim().isEmpty,
                  ),
                  const SizedBox(height: 20),

                  // Telefone
                  _campoTexto(
                    _telefoneCtrl,
                    "Telefone",
                    Icons.phone,
                    obrigatorio: false,
                  ),
                  const SizedBox(height: 20),

                  // Experiência (dropdown)
                  _tituloCampo(
                    "Experiência",
                    obrigatorio: true,
                    erro: _validando && experiencia == null,
                  ),
                  _dropdown(
                    experienciaOpcoes,
                    experiencia,
                    (val) => setState(() => experiencia = val),
                  ),
                  const SizedBox(height: 20),

                  // Disponibilidade (dropdown)
                  _tituloCampo(
                    "Disponibilidade",
                    obrigatorio: true,
                    erro: _validando && disponibilidade == null,
                  ),
                  _dropdown(
                    disponibilidadeOpcoes,
                    disponibilidade,
                    (val) => setState(() => disponibilidade = val),
                  ),
                  const SizedBox(height: 18),

                  tituloSecao("Localização", Icons.location_on, isMobile),
                  const SizedBox(height: 16),
                  // Nacionalidade (dropdown)
                  DropdownButtonFormField<String>(
                    value: _nacionalidade,
                    items: nacionalidades
                        .map(
                          (n) => DropdownMenuItem<String>(
                            value: n['sigla'],
                            child: Row(
                              children: [
                                Image.asset(n['asset']!, width: 28, height: 19),
                                const SizedBox(width: 10),
                                Text(
                                  n['nome']!,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                const SizedBox(width: 10),
                                Text(
                                  n['sigla']!,
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (sigla) =>
                        setState(() => _nacionalidade = sigla),
                    decoration: const InputDecoration(
                      labelText: 'Nacionalidade',
                      labelStyle: TextStyle(
                        color: Color(0xFF00FF00),
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF00FF00),
                          width: 1.8,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(11)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFF00FF00),
                          width: 2.6,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(14)),
                      ),
                    ),
                    dropdownColor: Colors.black,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(0xFF00FF00),
                    ),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Estado (dropdown)
                  // Estado (dropdown)
                  _tituloCampo(
                    "Estado",
                    obrigatorio: true,
                    erro: _validando && estado == null,
                  ),
                  _dropdown(
                    estados, // lista
                    estado, // selecionado
                    (val) => setState(() => estado = val), // callback
                  ),
                  const SizedBox(height: 15),
                  // Cidade
                  _campoTexto(
                    _cidadeCtrl,
                    "Cidade",
                    Icons.location_city,
                    obrigatorio: true,
                    erro: _validando && _cidadeCtrl.text.trim().isEmpty,
                  ),
                  const SizedBox(height: 15),
                  _campoTexto(
                    _cepCtrl,
                    'CEP',
                    Icons.map,
                    keyboardType: TextInputType.number,
                    hint: '00000-000',
                  ),
                  const SizedBox(height: 15),
                  _campoTexto(
                    _bairroCtrl,
                    'Bairro',
                    Icons.home_outlined,
                    hint: "Nome do seu bairro",
                  ),
                  const SizedBox(height: 20),

                  // Estilo tático (checkbox)
                  _tituloCampo(
                    "Estilo Tático",
                    obrigatorio: true,
                    erro: _validando && estilosSelecionados.isEmpty,
                  ),
                  Wrap(
                    spacing: 6,
                    children: estilosTaticos
                        .map(
                          (e) => CustomBadge(
                            text: e,
                            bgColor: Color(0xFF00FF00),
                            textColor: Colors.black,
                            fontSize: 14,
                          ),
                        )
                        .toList(),
                  ),
                  // Badges de níveis que treina
                  Wrap(
                    spacing: 6,
                    children: niveisSelecionados
                        .toList()
                        .map(
                          (n) => CustomBadge(
                            text: n,
                            bgColor: Color(0xFF36C2FF),
                            textColor: Colors.black,
                            fontSize: 14,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 34),

                  // Botão cadastrar
                  SizedBox(
                    height: 55,
                    child: ElevatedButton.icon(
                      onPressed: _cadastrar,
                      icon: const Icon(
                        Icons.sports_soccer,
                        color: Colors.black,
                        size: 30,
                      ),
                      label: const Text(
                        "Cadastrar Técnico",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 22,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00FF00),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        elevation: 4,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/'),
                      child: Text(
                        'Já tem uma conta? Fazer Login',
                        style: TextStyle(
                          color: const Color(0xFF00FF00),
                          fontWeight: FontWeight.w600,
                          fontSize: isMobile ? 19 : 21,
                        ),
                      ),
                    ),
                  ),
                  // Botão de Voltar logo abaixo
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Color(0xFF00FF00),
                    ),
                    label: const Text(
                      "Voltar",
                      style: TextStyle(
                        color: Color(0xFF00FF00),
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF00FF00),
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _tituloCampo(
    String label, {
    bool obrigatorio = false,
    bool erro = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text(
        label,
        style: TextStyle(
          color: erro ? Colors.red : const Color(0xFF00FF00),
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
    );
  }

  Widget _campoTexto(
    TextEditingController ctrl,
    String label,
    IconData icone, {
    bool obrigatorio = false,
    bool erro = false,
    String? hint,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tituloCampo(
          "$label${obrigatorio ? "" : ""}",
          obrigatorio: obrigatorio,
          erro: erro,
        ),
        TextField(
          controller: ctrl,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icone, color: const Color(0xFF00FF00)),
            filled: true,
            fillColor: Colors.black,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: erro ? Colors.red : const Color(0xFF00FF00),
                width: 2.1,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: erro ? Colors.red : const Color(0xFF00FF00),
                width: 2.3,
              ),
              borderRadius: BorderRadius.circular(13),
            ),
            hintText: label,
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.39)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dropdown(
    List<String> opcoes,
    String? value,
    void Function(String?) onChanged,
  ) {
    return SizedBox(
      height: 58,
      child: DropdownButtonFormField<String>(
        value: value,
        items: opcoes
            .map(
              (v) => DropdownMenuItem(
                value: v,
                child: Text(
                  v,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
        dropdownColor: const Color(0xFF00FF00),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2.1),
            borderRadius: BorderRadius.circular(13),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2.3),
            borderRadius: BorderRadius.circular(13),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 8,
          ),
        ),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 17,
        ),
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00FF00)),
      ),
    );
  }

  Widget _checkboxChip({
    required String label,
    required bool selected,
    required ValueChanged<bool> onChanged,
  }) {
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.black : Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      selected: selected,
      backgroundColor: Colors.black,
      selectedColor: const Color(0xFF00FF00),
      onSelected: onChanged,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: selected ? Colors.white : const Color(0xFF00FF00),
          width: 2,
        ),
      ),
      labelPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      elevation: selected ? 4 : 0,
      shadowColor: Colors.greenAccent.withOpacity(0.2),
    );
  }
}
