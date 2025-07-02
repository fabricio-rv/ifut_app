import 'package:flutter/material.dart';

class CadastroTorcedorPage extends StatefulWidget {
  const CadastroTorcedorPage({super.key});

  @override
  State<CadastroTorcedorPage> createState() => _CadastroTorcedorPageState();
}

class _CadastroTorcedorPageState extends State<CadastroTorcedorPage> {
  final _nomeCtrl = TextEditingController();
  final _apelidoCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _senhaCtrl = TextEditingController();
  final _confirmaSenhaCtrl = TextEditingController();
  final _telefoneCtrl = TextEditingController();
  final _cidadeCtrl = TextEditingController();
  final _bairroCtrl = TextEditingController();
  final _dataNascCtrl = TextEditingController();
  final _cepCtrl = TextEditingController();

  String? _estado;
  String? _timeCoracao;
  bool _mostrarSenha = false;
  bool _mostrarConfSenha = false;

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

  final List<String> _clubes = [
    "Nenhum",
    "Flamengo",
    "Corinthians",
    "Palmeiras",
    "São Paulo",
    "Grêmio",
    "Atlético-MG",
    "Vasco",
    "Cruzeiro",
    "Outro",
  ];

  final Map<String, bool> _notificacoes = {
    "Jogos próximos": false,
    "Promoções/sorteios": false,
    "Atualizações do app": false,
  };

  bool _validando = false;

  void _cadastrar() {
    setState(() => _validando = true);
    if (_nomeCtrl.text.trim().isEmpty ||
        _apelidoCtrl.text.trim().isEmpty ||
        _emailCtrl.text.trim().isEmpty ||
        _senhaCtrl.text.trim().isEmpty ||
        _confirmaSenhaCtrl.text.trim().isEmpty ||
        _senhaCtrl.text != _confirmaSenhaCtrl.text ||
        _dataNascCtrl.text.trim().isEmpty) {
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

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 0,
              vertical: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 14),
                Center(
                  child: Text(
                    "Cadastro de Torcedor FUT7",
                    style: TextStyle(
                      color: const Color(0xFF00FF00),
                      fontWeight: FontWeight.w900,
                      fontSize: isMobile ? 29 : 33,
                      letterSpacing: 0.7,
                      shadows: [
                        Shadow(
                          color: Colors.greenAccent.withOpacity(0.18),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Nome
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
                  "Apelido/Nome de exibição",
                  Icons.face,
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

                // Senha
                _campoSenha(
                  _senhaCtrl,
                  "Senha",
                  Icons.lock,
                  obrigatorio: true,
                  erro: _validando && _senhaCtrl.text.trim().isEmpty,
                  mostrar: _mostrarSenha,
                  onMostrar: () =>
                      setState(() => _mostrarSenha = !_mostrarSenha),
                ),
                const SizedBox(height: 20),

                // Confirmar Senha
                _campoSenha(
                  _confirmaSenhaCtrl,
                  "Confirmar Senha",
                  Icons.lock,
                  obrigatorio: true,
                  erro:
                      _validando &&
                      (_confirmaSenhaCtrl.text.trim().isEmpty ||
                          _senhaCtrl.text != _confirmaSenhaCtrl.text),
                  mostrar: _mostrarConfSenha,
                  onMostrar: () =>
                      setState(() => _mostrarConfSenha = !_mostrarConfSenha),
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

                _campoTexto(
                  _cepCtrl,
                  'CEP',
                  Icons.map,
                  keyboardType: TextInputType.number,
                  hint: '00000-000',
                ),
                const SizedBox(height: 16),

                // Cidade
                _campoTexto(
                  _cidadeCtrl,
                  "Cidade",
                  Icons.location_city,
                  obrigatorio: false,
                ),
                const SizedBox(height: 20),

                // Bairro
                _campoTexto(
                  _bairroCtrl,
                  "Bairro",
                  Icons.home,
                  obrigatorio: false,
                ),
                const SizedBox(height: 20),

                // Estado
                _dropdown(
                  _estados,
                  _estado,
                  (val) => setState(() => _estado = val),
                  "Estado",
                ),
                const SizedBox(height: 20),

                // Time do coração
                _dropdown(
                  _clubes,
                  _timeCoracao,
                  (val) => setState(() => _timeCoracao = val),
                  "Time do coração (opcional)",
                ),
                const SizedBox(height: 20),

                // Data de nascimento
                _campoTexto(
                  _dataNascCtrl,
                  "Data de nascimento",
                  Icons.cake,
                  obrigatorio: true,
                  erro: _validando && _dataNascCtrl.text.trim().isEmpty,
                  hint: "dd/mm/aaaa",
                  keyboardType: TextInputType.datetime,
                ),
                const SizedBox(height: 20),

                // Preferência de notificações
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    "Preferência de notificações:",
                    style: TextStyle(
                      color: const Color(0xFF00FF00),
                      fontWeight: FontWeight.w700,
                      fontSize: 18,
                    ),
                  ),
                ),
                ..._notificacoes.entries.map(
                  (entry) => CheckboxListTile(
                    title: Text(
                      entry.key,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    activeColor: const Color(0xFF00FF00),
                    checkColor: Colors.black,
                    value: entry.value,
                    onChanged: (val) =>
                        setState(() => _notificacoes[entry.key] = val ?? false),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                  ),
                ),
                const SizedBox(height: 34),

                SizedBox(
                  height: 55,
                  child: ElevatedButton.icon(
                    onPressed: _cadastrar,
                    icon: const Icon(
                      Icons.emoji_people,
                      color: Colors.black,
                      size: 30,
                    ),
                    label: const Text(
                      "Cadastrar Torcedor",
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
                const SizedBox(height: 10),
              ],
            ),
          ), // Center
        ), // SingleChildScrollView
      ), // SafeArea
    ); // Scaffold
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
        _tituloCampo(label, obrigatorio: obrigatorio, erro: erro),
        TextField(
          controller: ctrl,
          keyboardType: keyboardType,
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
            hintText: hint ?? label,
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

  Widget _campoSenha(
    TextEditingController ctrl,
    String label,
    IconData icone, {
    required bool mostrar,
    required VoidCallback onMostrar,
    bool obrigatorio = false,
    bool erro = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _tituloCampo(label, obrigatorio: obrigatorio, erro: erro),
        TextField(
          controller: ctrl,
          obscureText: !mostrar,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
          decoration: InputDecoration(
            prefixIcon: Icon(icone, color: const Color(0xFF00FF00)),
            suffixIcon: IconButton(
              icon: Icon(
                mostrar ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xFF00FF00),
              ),
              onPressed: onMostrar,
            ),
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
}
