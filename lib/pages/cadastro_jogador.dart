import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'components/card_jogador_tecnico.dart';
import 'components/campinho_fut7.dart';
import 'components/nacionalidade.dart';
import 'components/banco_reservas.dart';

class CadastroJogadorPage extends StatefulWidget {
  const CadastroJogadorPage({super.key});

  @override
  State<CadastroJogadorPage> createState() => _CadastroJogadorPageState();
}

class _CadastroJogadorPageState extends State<CadastroJogadorPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeCtrl = TextEditingController();
  final _apelidoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _telCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmaSenhaCtrl = TextEditingController();
  final _nascCtrl = TextEditingController();
  final _alturaCtrl = TextEditingController();
  final _pesoCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final List<String> estilosTaticos = [];
  final List<String> niveisQueTreina = [];
  final String experiencia = '';
  final String disponibilidade = '';

  File? fotoPerfil;
  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => fotoPerfil = File(picked.path));
    }
  }

  String? _estado;
  final List<String> _estados = [
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

  final List<String> _niveisJogo = [
    "Pereba",
    "Resenha",
    "Casual",
    "Intermediário",
    "Avançado",
    "Competidor",
    "Semi-Amador",
    "Amador",
    "Ex-profissional",
  ];
  final Set<String> _niveisSelecionados = {};

  final posicoesCampo = [
    PosicaoCampo("Pivô", "🥅"),
    PosicaoCampo("1º Meio", "🎯"),
    PosicaoCampo("2º Meio", "🎩"),
    PosicaoCampo("Ala E", "🏹"),
    PosicaoCampo("Ala D", "⚡"),
    PosicaoCampo("Fixo", "🛡️"),
    PosicaoCampo("Goleiro", "🧤"),
  ];

  String? posicaoPrincipal = '';
  Set<String> posicoesSecundarias = {};
  String? _peDominante;
  bool _mostrarSenha = false;
  bool _mostrarConfSenha = false;
  bool _validando = false;
  final String _fotoUrl = ''; // Foto de perfil (pode começar vazio)
  String? _nacionalidade = 'BRA'; // Nacionalidade padrão (ou vazio)
  final String _escudoClube = '';
  final Set<String> _badgesSelecionadas = {};

  @override
  void dispose() {
    _nomeCtrl.dispose();
    _apelidoCtrl.dispose();
    _emailCtrl.dispose();
    _telCtrl.dispose();
    _senhaCtrl.dispose();
    _confirmaSenhaCtrl.dispose();
    _nascCtrl.dispose();
    _alturaCtrl.dispose();
    _pesoCtrl.dispose();
    _cepCtrl.dispose();
    _bairroCtrl.dispose();
    super.dispose();
  }

  void _cadastrar() {
    setState(() => _validando = true);
    // Validação mínima
    if (_nomeCtrl.text.trim().isEmpty ||
        _apelidoCtrl.text.trim().isEmpty ||
        _emailCtrl.text.trim().isEmpty ||
        _senhaCtrl.text.trim().isEmpty ||
        _confirmaSenhaCtrl.text.trim().isEmpty ||
        _senhaCtrl.text != _confirmaSenhaCtrl.text ||
        _nascCtrl.text.trim().isEmpty ||
        _estado == null ||
        _cidadeCtrl.text.trim().isEmpty
    // ...adicione outros obrigatórios
    ) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Preencha todos os campos obrigatórios!"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }
    // TODO: salvar cadastro...
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
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 0,
                vertical: 30,
              ),
              child: Container(
                constraints: const BoxConstraints(maxWidth: 520),
                width: double.infinity,
                padding: const EdgeInsets.all(0),
                child: isMobile
                    ? Column(
                        children: [
                          JogadorTecnicoCard(
                            nome: _nomeCtrl.text,
                            apelido: _apelidoCtrl.text,
                            fotoUrl: _fotoUrl ?? '', // ou '' se não usar foto
                            nacionalidade: _nacionalidade ?? '',
                            overall: 50, // pode atualizar conforme seu app
                            nivel: 0,
                            posicaoPrincipal: posicaoPrincipal ?? '',
                            posicoesSecundarias: posicoesSecundarias.toList(),
                            peDominante: _peDominante ?? '',
                            altura: int.tryParse(_alturaCtrl.text) ?? 0,
                            peso: int.tryParse(_pesoCtrl.text) ?? 0,
                            escudoClube:
                                _escudoClube ??
                                '', // ou passe null/'' se sem clube
                            tipoPerfil: 'Jogador', // ou 'Técnico'
                            niveis: _niveisSelecionados.toList(),
                            badges: _badgesSelecionadas.toList(),
                            estilosTaticos: const [],
                            niveisQueTreina: const [],
                            experiencia: '',
                            disponibilidade: '',
                          ),
                          const SizedBox(height: 18),
                          _formularioCadastro(isMobile),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: JogadorTecnicoCard(
                                nome: _nomeCtrl.text,
                                apelido: _apelidoCtrl.text,
                                fotoUrl: _fotoUrl ?? '',
                                nacionalidade: _nacionalidade ?? '',
                                overall: 50,
                                nivel: 0,
                                posicaoPrincipal: posicaoPrincipal ?? '',
                                posicoesSecundarias: posicoesSecundarias
                                    .toList(),
                                peDominante: _peDominante ?? '',
                                altura: int.tryParse(_alturaCtrl.text) ?? 0,
                                peso: int.tryParse(_pesoCtrl.text) ?? 0,
                                escudoClube: _escudoClube ?? '',
                                tipoPerfil: 'Jogador', // ou 'Técnico'
                                niveis: _niveisSelecionados.toList(),
                                badges: _badgesSelecionadas.toList(),
                                estilosTaticos: const [],
                                niveisQueTreina: const [],
                                experiencia: '',
                                disponibilidade: '',
                              ),
                            ),
                          ),
                          const SizedBox(width: 40),
                          Expanded(
                            flex: 8,
                            child: _formularioCadastro(isMobile),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _formularioCadastro(bool isMobile) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: isMobile
            ? CrossAxisAlignment.center
            : CrossAxisAlignment.start,
        children: [
          Text(
            'Criar Conta Jogador',
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
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 7),
          Text(
            'Junte-se à comunidade FUT7',
            style: TextStyle(
              color: Colors.white.withOpacity(0.82),
              fontSize: isMobile ? 18 : 20,
            ),
            textAlign: isMobile ? TextAlign.center : TextAlign.left,
          ),
          const SizedBox(height: 28),

          _tituloSecao("Dados Pessoais", Icons.account_circle, isMobile),
          _campoTexto(_nomeCtrl, 'Nome Completo', Icons.person),
          const SizedBox(height: 16),
          _campoTexto(
            _apelidoCtrl,
            'Apelido',
            Icons.face_retouching_natural,
            hint: "Ex: Zico, Bebeto...",
          ),
          const SizedBox(height: 16),
          _campoTexto(_emailCtrl, 'Email', Icons.email, hint: 'seu@gmail.com'),
          const SizedBox(height: 16),
          _campoTexto(
            _telCtrl,
            'Telefone',
            Icons.phone_android,
            keyboardType: TextInputType.phone,
            hint: '(11) 99999-9999',
          ),
          const SizedBox(height: 16),
          _campoTexto(
            _nascCtrl,
            'Data de Nascimento',
            Icons.cake,
            hint: "dd/mm/aaaa",
            keyboardType: TextInputType.datetime,
          ),
          const SizedBox(height: 16),
          _campoSenha(
            _senhaCtrl,
            'Senha',
            Icons.lock,
            mostrar: _mostrarSenha,
            onMostrar: () => setState(() => _mostrarSenha = !_mostrarSenha),
          ),
          const SizedBox(height: 16),
          _campoSenha(
            _confirmaSenhaCtrl,
            'Confirmar Senha',
            Icons.lock,
            mostrar: _mostrarConfSenha,
            onMostrar: () =>
                setState(() => _mostrarConfSenha = !_mostrarConfSenha),
          ),
          const SizedBox(height: 30),

          _tituloSecao(
            "Características Físicas",
            Icons.fitness_center,
            isMobile,
          ),
          _campoTexto(
            _alturaCtrl,
            'Altura (cm)',
            Icons.height,
            hint: '175',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          _campoTexto(
            _pesoCtrl,
            'Peso (kg)',
            Icons.monitor_weight,
            hint: '70.5',
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),

          // Pé Dominante
          _tituloSecao("Pé Dominante", Icons.directions_walk, isMobile),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _botaoPe("Destro", Icons.directions_run),
              const SizedBox(height: 12),
              _botaoPe("Canhoto", Icons.directions_walk),
              const SizedBox(height: 12),
              _botaoPe("Ambidestro", Icons.accessibility_new),
            ],
          ),
          const SizedBox(height: 24),

          _tituloSecao("Localização", Icons.location_on, isMobile),
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
                        Text(n['nome']!, style: const TextStyle(fontSize: 18)),
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
            onChanged: (sigla) => setState(() => _nacionalidade = sigla),
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
                borderSide: BorderSide(color: Color(0xFF00FF00), width: 1.8),
                borderRadius: BorderRadius.all(Radius.circular(11)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF00FF00), width: 2.6),
                borderRadius: BorderRadius.all(Radius.circular(14)),
              ),
            ),
            dropdownColor: Colors.black,
            icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF00FF00)),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          // Estado (dropdown)
          _dropdown(
            _estados,
            _estado,
            (val) => setState(() => _estado = val),
            "Estado",
          ),
          const SizedBox(height: 16),
          // Cidade
          _campoTexto(
            _cidadeCtrl,
            "Cidade",
            Icons.location_city,
            obrigatorio: true,
            erro: _validando && _cidadeCtrl.text.trim().isEmpty,
          ),
          const SizedBox(height: 16),
          _campoTexto(
            _cepCtrl,
            'CEP',
            Icons.map,
            keyboardType: TextInputType.number,
            hint: '00000-000',
          ),
          const SizedBox(height: 16),
          _campoTexto(
            _bairroCtrl,
            'Bairro',
            Icons.home_outlined,
            hint: "Nome do seu bairro",
          ),
          const SizedBox(height: 24),

          _tituloSecao("Nível de Jogo", Icons.emoji_events, isMobile),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Wrap(
              spacing: 16,
              runSpacing: 14,
              children: _niveisJogo
                  .map(
                    (nivel) => FilterChip(
                      label: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 8,
                        ),
                        child: Text(
                          nivel,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 19,
                          ),
                        ),
                      ),
                      labelStyle: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      selected: _niveisSelecionados.contains(nivel),
                      selectedColor: Colors.green.withOpacity(0.6),
                      checkmarkColor: Colors.black,
                      backgroundColor: Colors.black,
                      side: const BorderSide(color: Color(0xFF00FF00)),
                      onSelected: (sel) => setState(() {
                        sel
                            ? _niveisSelecionados.add(nivel)
                            : _niveisSelecionados.remove(nivel);
                      }),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(height: 28),

          _tituloSecao("Posições Preferidas", Icons.sports, isMobile),
          const SizedBox(height: 2),
          Text(
            "Selecione posição principal (clique) e secundária (duplo clique)",
            style: TextStyle(
              color: Colors.white.withOpacity(0.86),
              fontSize: isMobile ? 17 : 19,
            ),
          ),
          const SizedBox(height: 20),
          CampinhoFUT7(
            posicoes: posicoesCampo,
            principal: posicaoPrincipal,
            secundarias: posicoesSecundarias,
            onSelect: (nome) {
              setState(() {
                if (posicaoPrincipal == null || posicaoPrincipal!.isEmpty) {
                  posicaoPrincipal = nome;
                } else if (posicaoPrincipal == nome) {
                  posicaoPrincipal = '';
                } else {
                  if (posicoesSecundarias.contains(nome)) {
                    posicoesSecundarias.remove(nome);
                  } else {
                    posicoesSecundarias.add(nome);
                  }
                }
              });
            },
          ),
          BancoReservasFUT7(
            onSelect: (idx) {
              setState(() {
                // lógica de seleção se quiser, exemplo:
                // reservaSelecionada = idx;
              });
            },
            selecionado:
                null, // ou o index do selecionado se quiser destacar algum
          ),
          const SizedBox(height: 28),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FF00),
                foregroundColor: Colors.black,
                textStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 22 : 26,
                  letterSpacing: 1.1,
                ),
                minimumSize: const Size(0, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(13),
                ),
                shadowColor: Colors.greenAccent,
                elevation: 11,
              ),
              icon: const Icon(Icons.person_add_alt_1, size: 36),
              label: const Text('CRIAR CONTA'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Cadastro enviado! (Simulado)'),
                    ),
                  );
                }
              },
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
            icon: const Icon(Icons.arrow_back, color: Color(0xFF00FF00)),
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
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _tituloSecao(String texto, IconData icone, bool mobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 13),
      child: Row(
        children: [
          Icon(icone, color: const Color(0xFF00FF00), size: 28),
          const SizedBox(width: 9),
          Text(
            texto,
            style: TextStyle(
              color: const Color(0xFF00FF00),
              fontSize: mobile ? 21 : 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.6,
            ),
          ),
        ],
      ),
    );
  }

  Widget _campoTexto(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    String? hint,
    TextInputType? keyboardType,
    String Function(String?)? validator,
    bool obrigatorio = false,
    bool erro = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TextFormField(
        controller: ctrl,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(color: Colors.white, fontSize: 21),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF00FF00)),
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF00FF00),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white38, fontSize: 17),
          filled: true,
          fillColor: Colors.black,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 22,
            horizontal: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 1.8),
            borderRadius: BorderRadius.circular(11),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2.6),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _dropdown(
    List<String> opcoes,
    String? value,
    void Function(String?) onChanged,
    String label,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tituloCampo(label),
        SizedBox(
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
                borderSide: const BorderSide(
                  color: Color(0xFF00FF00),
                  width: 2.1,
                ),
                borderRadius: BorderRadius.circular(13),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(
                  color: Color(0xFF00FF00),
                  width: 2.3,
                ),
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
        ),
      ],
    );
  }

  Widget _tituloCampo(String label, {bool erro = false}) {
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

  Widget _campoSenha(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    required bool mostrar,
    required VoidCallback onMostrar,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: TextFormField(
        controller: ctrl,
        obscureText: !mostrar,
        style: const TextStyle(color: Colors.white, fontSize: 21),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: const Color(0xFF00FF00)),
          labelText: label,
          labelStyle: const TextStyle(
            color: Color(0xFF00FF00),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          filled: true,
          fillColor: Colors.black,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 22,
            horizontal: 18,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 1.8),
            borderRadius: BorderRadius.circular(11),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0xFF00FF00), width: 2.6),
            borderRadius: BorderRadius.circular(14),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              mostrar ? Icons.visibility : Icons.visibility_off,
              color: const Color(0xFF00FF00),
            ),
            onPressed: onMostrar,
          ),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _botaoPe(String texto, IconData icone) {
    final selected = _peDominante == texto;
    return OutlinedButton.icon(
      style: OutlinedButton.styleFrom(
        foregroundColor: selected ? Colors.black : const Color(0xFF00FF00),
        backgroundColor: selected
            ? const Color(0xFF00FF00)
            : Colors.transparent,
        side: BorderSide(
          color: selected ? const Color(0xFF00FF00) : Colors.green,
          width: 2.2,
        ),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(13)),
      ),
      icon: Icon(icone, size: 27),
      label: Text(texto, textAlign: TextAlign.center),
      onPressed: () => setState(() => _peDominante = texto),
    );
  }
}
