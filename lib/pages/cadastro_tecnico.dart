// cadastro_tecnico_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'controllers/tecnico_controller.dart';
import 'controllers/experiencia_controller.dart';
import 'controllers/disponibilidade_controller.dart';
import 'controllers/calendario_controller.dart';

import 'models/cadastro_tecnico_model.dart';
import 'models/experiencia_model.dart';
import 'models/disponibilidade_model.dart';
import 'components/card_jogador_tecnico.dart';

import 'widgets/campos/campo_texto.dart';
import 'widgets/campos/campo_senha.dart';
import 'widgets/campos/campo_data.dart';
import 'widgets/dropdown/nacionalidade.dart';
import 'widgets/dropdown/dropdown_estado.dart';
import 'widgets/dropdown/dropdown_disponibilidade.dart';
import 'widgets/dropdown/dropdown_experiencia.dart';
import 'widgets/atributos/niveis_treinador.dart';
import 'widgets/atributos/estilo_tatico.dart';
import 'widgets/botoes/botao_criar_conta.dart';
import 'widgets/botoes/botao_voltar.dart';
import 'widgets/campos/titulo_secao.dart';
import 'widgets/botoes/botao_login.dart';
import 'widgets/dropdown/calendario.dart';

import 'utils/validadores.dart';

class CadastroPageState extends State<CadastroTecnicoPage> {
  final calendarioCtrl = CalendarioController();

  @override
  void dispose() {
    calendarioCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CampoData(
      controller: calendarioCtrl.dataCtrl,
      label: 'Data de Nascimento',
      icon: Icons.cake,
      validator: (value) {
        if (value == null || value.isEmpty) return 'Campo obrigatório';
        return null;
      },
      onCalendario: () => calendarioCtrl.escolherData(context),
    );
  }
}

String? _nacionalidade = 'BRA';
XFile? _imagemPerfil;

class CadastroTecnicoPage extends StatefulWidget {
  const CadastroTecnicoPage({super.key});

  @override
  State<CadastroTecnicoPage> createState() => _CadastroTecnicoPageState();
}

class _CadastroTecnicoPageState extends State<CadastroTecnicoPage> {
  final _formKey = GlobalKey<FormState>();

  bool _mostrarSenha = false;
  bool _mostrarConfSenha = false;
  bool _validando = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    Future<void> _selecionarImagem(BuildContext context) async {
      final ImagePicker picker = ImagePicker();
      final XFile? imagemSelecionada = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (imagemSelecionada != null) {
        setState(() {
          _imagemPerfil = imagemSelecionada;
          // Atualize o controlador/foto do técnico aqui também, se quiser:
          // tecnicoCtrl.setFotoPerfil(_imagemPerfil!.path);
        });
      }
    }

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TecnicoController()),
        ChangeNotifierProvider(create: (_) => ExperienciaController()),
        ChangeNotifierProvider(create: (_) => DisponibilidadeController()),
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/fundo_estadio.png", fit: BoxFit.cover),
            Container(color: Colors.black.withOpacity(0.40)),
            SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 0,
                  vertical: 30,
                ),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 520),
                    width: double.infinity,
                    child:
                        Consumer3<
                          TecnicoController,
                          ExperienciaController,
                          DisponibilidadeController
                        >(
                          builder: (context, tecnicoCtrl, experienciaCtrl, dispoCtrl, _) {
                            return Form(
                              key: tecnicoCtrl.formKey,
                              child: Column(
                                crossAxisAlignment: isMobile
                                    ? CrossAxisAlignment.center
                                    : CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Cadastro de Técnico',
                                    style: TextStyle(
                                      fontSize: isMobile ? 32 : 40,
                                      fontWeight: FontWeight.bold,
                                      color: const Color(0xFF00FF00),
                                      letterSpacing: 1.1,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 20),
                                  JogadorTecnicoCard(
                                    nome: tecnicoCtrl.nomeCtrl.text,
                                    apelido: tecnicoCtrl.apelidoCtrl.text,
                                    fotoUrl: tecnicoCtrl.fotoPerfil ?? '',
                                    nacionalidade:
                                        tecnicoCtrl.nacionalidade ?? 'BRA',
                                    overall: 50,
                                    nivel: 0,
                                    posicaoPrincipal: 'TÉC',
                                    posicoesSecundarias: const [],
                                    peDominante: '',
                                    altura: 0,
                                    peso: 0,
                                    niveis: tecnicoCtrl.niveisQueTreina
                                        .toList(),
                                    badges: const [],
                                    tipoPerfil: 'Técnico',
                                    estilosTaticos: tecnicoCtrl.estilosTaticos
                                        .toList(),
                                    niveisQueTreina: tecnicoCtrl.niveisQueTreina
                                        .toList(),
                                    experiencia:
                                        experienciaCtrl
                                            .experienciaSelecionada ??
                                        '',
                                    disponibilidade:
                                        dispoCtrl.disponibilidadeSelecionada ??
                                        '',
                                    dataNascimento: tecnicoCtrl.dataNascimento,
                                    estado: tecnicoCtrl.estado,
                                    exibirEscolherFoto: true,
                                    onSelecionarFoto: _selecionarImagem,
                                  ),

                                  const SizedBox(height: 16),

                                  // Dados Pessoais
                                  TituloSecao(
                                    'Dados Pessoais',
                                    Icons.account_circle,
                                    isMobile,
                                  ),

                                  CampoTexto(
                                    controller: tecnicoCtrl.nomeCtrl,
                                    label: 'Nome Completo',
                                    icon: Icons.person,
                                    hint: "Ex: João Silva",
                                    validator: Validadores.validaNome,
                                    onChanged: tecnicoCtrl.setNome,
                                  ),
                                  const SizedBox(height: 16),

                                  CampoTexto(
                                    controller: tecnicoCtrl.apelidoCtrl,
                                    label: 'Apelido',
                                    icon: Icons.face,
                                    hint: "Ex: Zico, Bebeto, etc.",
                                    validator: Validadores.validaApelido,
                                    onChanged: tecnicoCtrl.setApelido,
                                  ),
                                  const SizedBox(height: 16),

                                  CampoTexto(
                                    controller: tecnicoCtrl.emailCtrl,
                                    label: 'Email',
                                    icon: Icons.email,
                                    hint: "Ex: seu@gmail.com",
                                    validator: Validadores.validaEmail,
                                    keyboardType: TextInputType.emailAddress,
                                    onChanged: tecnicoCtrl.setEmail,
                                  ),
                                  const SizedBox(height: 16),

                                  CampoData(
                                    controller: tecnicoCtrl.dataNascimentoCtrl,
                                    label: 'Data de Nascimento',
                                    icon: Icons.cake,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Campo obrigatório';
                                      }
                                      return null;
                                    },
                                    onChanged: (_) {},
                                    onCalendario: () async {
                                      DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate:
                                            tecnicoCtrl.dataNascimento ??
                                            DateTime(1980),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                        builder: (context, child) {
                                          return Theme(
                                            data: ThemeData.dark().copyWith(
                                              colorScheme:
                                                  const ColorScheme.dark(
                                                    primary: Color(0xFF00FF00),
                                                    onPrimary: Colors.black,
                                                    surface: Colors.black,
                                                    onSurface: Colors.white,
                                                  ),
                                            ),
                                            child: child!,
                                          );
                                        },
                                      );
                                      if (picked != null) {
                                        tecnicoCtrl.setDataNascimento(picked);
                                      }
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  CampoSenha(
                                    controller: tecnicoCtrl.senhaCtrl,
                                    label: 'Senha',
                                    icon: Icons.lock,
                                    mostrar: _mostrarSenha,
                                    onMostrar: () => setState(
                                      () => _mostrarSenha = !_mostrarSenha,
                                    ),
                                    validator: Validadores.validaSenha,
                                    classificaForcaSenha:
                                        Validadores.classificaForcaSenha,
                                    corForcaSenha: Validadores.corForcaSenha,
                                    onChanged: tecnicoCtrl.setSenha,
                                  ),
                                  const SizedBox(height: 16),

                                  CampoSenha(
                                    controller: tecnicoCtrl.confirmarSenhaCtrl,
                                    label: 'Confirmar Senha',
                                    icon: Icons.lock,
                                    mostrar: _mostrarConfSenha,
                                    onMostrar: () => setState(
                                      () => _mostrarConfSenha =
                                          !_mostrarConfSenha,
                                    ),
                                    validator: (v) =>
                                        Validadores.validaConfirmarSenha(
                                          v,
                                          tecnicoCtrl.senhaCtrl.text,
                                        ),
                                    classificaForcaSenha: (senhaConfirm) {
                                      if (senhaConfirm !=
                                          tecnicoCtrl.senhaCtrl.text)
                                        return "Senhas não conferem";
                                      return Validadores.classificaForcaSenha(
                                        senhaConfirm ?? '',
                                      );
                                    },
                                    corForcaSenha: (senhaConfirm) {
                                      if (senhaConfirm !=
                                          tecnicoCtrl.senhaCtrl.text)
                                        return Colors.red;
                                      return Validadores.corForcaSenha(
                                        senhaConfirm ?? '',
                                      );
                                    },
                                    onChanged: tecnicoCtrl.setConfirmarSenha,
                                  ),
                                  const SizedBox(height: 16),

                                  // Localização
                                  TituloSecao(
                                    "Localização",
                                    Icons.location_on,
                                    isMobile,
                                  ),
                                  const SizedBox(height: 3),

                                  NacionalidadeDropdown(
                                    value: tecnicoCtrl.nacionalidade,
                                    onChanged: tecnicoCtrl.setNacionalidade,
                                  ),
                                  const SizedBox(height: 20),

                                  EstadoDropdown(
                                    value: (tecnicoCtrl.estado?.isEmpty ?? true)
                                        ? "RS"
                                        : tecnicoCtrl.estado,
                                    onChanged: tecnicoCtrl.setEstado,
                                    label: 'Estado',
                                    obrigatorio: true,
                                  ),
                                  const SizedBox(height: 16),

                                  CampoTexto(
                                    controller: tecnicoCtrl.cidadeCtrl,
                                    label: 'Cidade',
                                    icon: Icons.location_city,
                                    hint: "Nome da sua cidade",
                                    validator:
                                        Validadores.validaCampoObrigatorio,
                                    onChanged: tecnicoCtrl.setCidade,
                                  ),
                                  const SizedBox(height: 16),

                                  CampoTexto(
                                    controller: tecnicoCtrl.cepCtrl,
                                    label: 'CEP',
                                    icon: Icons.pin_drop,
                                    keyboardType: TextInputType.number,
                                    hint: '00000-000',
                                    validator:
                                        Validadores.validaCampoObrigatorio,
                                    onChanged: tecnicoCtrl.setCep,
                                  ),
                                  const SizedBox(height: 16),

                                  CampoTexto(
                                    controller: tecnicoCtrl.bairroCtrl,
                                    label: 'Bairro',
                                    icon: Icons.home_outlined,
                                    hint: "Nome do seu bairro",
                                    validator:
                                        Validadores.validaCampoObrigatorio,
                                    onChanged: tecnicoCtrl.setBairro,
                                  ),
                                  const SizedBox(height: 20),

                                  TituloSecao(
                                    "Informações Técnicas",
                                    Icons.work_outline,
                                    isMobile,
                                  ),
                                  const SizedBox(height: 3),

                                  // Experiência
                                  DropdownExperiencia(
                                    experiencias: ExperienciaModel.exemplos
                                        .map((e) => e.valor)
                                        .toList(),
                                    value: tecnicoCtrl.experienciaSelecionada,
                                    onChanged: (val) {
                                      tecnicoCtrl.setExperiencia(val);
                                    },
                                  ),
                                  const SizedBox(height: 16),

                                  // Disponibilidade
                                  DropdownDisponibilidade(
                                    disponiveis: DisponibilidadeModel.exemplos
                                        .map((d) => d.valor)
                                        .toList(),
                                    value:
                                        tecnicoCtrl.disponibilidadeSelecionada,
                                    onChanged: (val) {
                                      tecnicoCtrl.setDisponibilidade(
                                        val,
                                      ); // para atualizar a UI se necessário
                                    },
                                  ),
                                  const SizedBox(height: 4),

                                  // Níveis que Treina
                                  TituloSecao(
                                    "Níveis que Treina (Máx: 3)",
                                    Icons.emoji_events,
                                    isMobile,
                                  ),
                                  NiveisTreinadorSelector(
                                    selecionados: tecnicoCtrl.niveisQueTreina,
                                    onChanged: tecnicoCtrl.setNiveisQueTreina,
                                  ),
                                  const SizedBox(height: 8),

                                  // Estilos Táticos
                                  TituloSecao(
                                    "Estilos Táticos (Máx: 3)",
                                    Icons.track_changes,
                                    isMobile,
                                  ),
                                  EstiloTaticoSelector(
                                    selecionados: tecnicoCtrl.estilosTaticos,
                                    onChanged: tecnicoCtrl.setEstilosTaticos,
                                  ),
                                  const SizedBox(height: 24),

                                  // Dentro do widget de formulário técnico, no botão "Criar Conta" por exemplo:
                                  BotaoCriarConta(
                                    onPressed: () async {
                                      // Copia todos os campos do formulário visual para o controller!
                                      tecnicoCtrl.setNome(
                                        tecnicoCtrl.nomeCtrl.text,
                                      );
                                      tecnicoCtrl.setApelido(
                                        tecnicoCtrl.apelidoCtrl.text,
                                      );
                                      tecnicoCtrl.setEmail(
                                        tecnicoCtrl.emailCtrl.text
                                            .trim()
                                            .toLowerCase(),
                                      );

                                      tecnicoCtrl.setSenha(
                                        tecnicoCtrl.senhaCtrl.text,
                                      );
                                      tecnicoCtrl.setConfirmarSenha(
                                        tecnicoCtrl.confirmarSenhaCtrl.text,
                                      );
                                      tecnicoCtrl.setDataNascimento(
                                        tecnicoCtrl.dataNascimento,
                                      );

                                      tecnicoCtrl.setNacionalidade(
                                        tecnicoCtrl.nacionalidade,
                                      );
                                      tecnicoCtrl.setEstado(
                                        tecnicoCtrl.estado ?? '',
                                      );
                                      tecnicoCtrl.setCidade(
                                        tecnicoCtrl.cidadeCtrl.text,
                                      );
                                      tecnicoCtrl.setBairro(
                                        tecnicoCtrl.bairroCtrl.text,
                                      );
                                      tecnicoCtrl.setCep(
                                        tecnicoCtrl.cepCtrl.text,
                                      );

                                      tecnicoCtrl.setExperiencia(
                                        tecnicoCtrl.experienciaSelecionada,
                                      );
                                      tecnicoCtrl.setDisponibilidade(
                                        tecnicoCtrl.disponibilidadeSelecionada,
                                      );
                                      tecnicoCtrl.setNiveisQueTreina(
                                        tecnicoCtrl.niveisQueTreina,
                                      );
                                      tecnicoCtrl.setEstilosTaticos(
                                        tecnicoCtrl.estilosTaticos,
                                      );

                                      // Agora sim, chama o método para cadastrar no backend
                                      await tecnicoCtrl.cadastrar(context);

                                      setState(
                                        () => tecnicoCtrl.validando = true,
                                      );
                                    },
                                    isMobile: isMobile,
                                  ),

                                  const SizedBox(height: 20),
                                  BotaoLogin(
                                    onPressed: () =>
                                        Navigator.pushNamed(context, '/'),
                                    isMobile: isMobile,
                                  ),
                                  const SizedBox(height: 20),
                                  BotaoVoltar(
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                  const SizedBox(height: 6),
                                ],
                              ),
                            );
                          },
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tituloSecao(String titulo, bool isMobile) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Text(
        titulo,
        style: TextStyle(
          color: const Color(0xFF00FF00),
          fontWeight: FontWeight.bold,
          fontSize: isMobile ? 22 : 26,
        ),
      ),
    );
  }
}
