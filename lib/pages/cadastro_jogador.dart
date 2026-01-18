import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_cropper/image_cropper.dart';

import 'package:provider/provider.dart';
import 'controllers/dados_pessoais_controller.dart';
import 'controllers/caracteristicas_fisicas_controller.dart';
import 'controllers/localizacao_controller.dart';
import 'controllers/jogador_controller.dart';
import 'controllers/calendario_controller.dart';

import 'components/card_jogador_tecnico.dart';
import 'components/campinho_fut7.dart';
import 'components/banco_reservas.dart';

import 'widgets/campos/campo_texto.dart';
import 'widgets/campos/campo_senha.dart';
import 'widgets/campos/campo_data.dart';
import 'widgets/dropdown/dropdown_estado.dart';
import 'widgets/dropdown/nacionalidade.dart';
import 'widgets/botoes/botao_pe.dart';
import 'widgets/campos/titulo_secao.dart';
import 'widgets/atributos/niveis_jogador.dart';
import 'widgets/botoes/botao_voltar.dart';
import 'widgets/botoes/botao_login.dart';
import 'widgets/botoes/botao_criar_conta.dart';
import 'widgets/dropdown/calendario.dart';

import 'utils/validadores.dart';

import 'models/cadastro_jogador_model.dart';
import 'models/dados_pessoais_model.dart';
import 'models/caracteristicas_fisicas_model.dart';
import 'models/localizacao_model.dart';
import 'models/jogo_model.dart';

class CadastroPageState extends State<CadastroJogadorPage> {
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

class CadastroJogadorPage extends StatefulWidget {
  const CadastroJogadorPage({super.key});

  @override
  State<CadastroJogadorPage> createState() => _CadastroJogadorPageState();
}

class _CadastroJogadorPageState extends State<CadastroJogadorPage> {
  File? fotoPerfil;
  File? _imagemPerfil;
  final picker = ImagePicker();

  Future<File?> cropImagem(File file) async {
    final cropped = await ImageCropper().cropImage(
      sourcePath: file.path,
      compressQuality: 90,
      aspectRatio: const CropAspectRatio(
        ratioX: 3,
        ratioY: 4,
      ), // 3:4 vertical tipo FIFA
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Ajuste sua foto',
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.greenAccent,
          lockAspectRatio: true, // trava no 3:4!
        ),
        IOSUiSettings(
          title: 'Ajuste sua foto',
          aspectRatioLockEnabled: true,
          aspectRatioPickerButtonHidden: true,
        ),
      ],
    );
    if (cropped != null) return File(cropped.path);
    return null;
  }

  Future<void> _selecionarImagem(BuildContext context) async {
    final XFile? pickedFile = await picker.pickImage(
      source: await _showEscolhaFonte(context),
      imageQuality: 60, // boa qualidade, reduz o tamanho
    );
    if (pickedFile != null) {
      File original = File(pickedFile.path);

      // Abre cropper para usuário ajustar/cortar melhor
      File? cropFinal = await cropImagem(original);

      setState(() {
        _imagemPerfil = cropFinal ?? original;
      });
    }
  }

  Future<ImageSource> _showEscolhaFonte(BuildContext context) async {
    final result = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (ctx) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.camera_alt, color: Colors.greenAccent),
            title: Text('Tirar foto'),
            onTap: () => Navigator.pop(ctx, ImageSource.camera),
          ),
          ListTile(
            leading: Icon(Icons.photo_library, color: Colors.greenAccent),
            title: Text('Escolher da galeria'),
            onTap: () => Navigator.pop(ctx, ImageSource.gallery),
          ),
        ],
      ),
    );
    return result ?? ImageSource.gallery; // padrão
  }

  String _fotoUrlParaCard() {
    // Se selecionou uma imagem local, mostra ela, senão retorna ''
    if (_imagemPerfil != null) return _imagemPerfil!.path;
    return '';
  }

  Future<void> pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() => fotoPerfil = File(picked.path));
    }
  }

  final posicoesCampo = [
    PosicaoCampo("Pivô", "🥅"),
    PosicaoCampo("1º Meio", "🎯"),
    PosicaoCampo("2º Meio", "🎩"),
    PosicaoCampo("Ala E", "🏹"),
    PosicaoCampo("Ala D", "⚡"),
    PosicaoCampo("Fixo", "🛡️"),
    PosicaoCampo("Goleiro", "🧤"),
  ];

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DadosPessoaisController()),
        ChangeNotifierProvider(
          create: (_) => CaracteristicasFisicasController(),
        ),
        ChangeNotifierProvider(create: (_) => LocalizacaoController()),
        ChangeNotifierProvider(
          create: (_) => JogadorController(),
        ), // Added JogadorController provider
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
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 16 : 0,
                      vertical: 30,
                    ),
                    child: Container(
                      constraints: const BoxConstraints(maxWidth: 520),
                      width: double.infinity,
                      child: isMobile
                          ? Column(
                              children: [
                                Text(
                                  'Cadastro de Jogador',
                                  style: TextStyle(
                                    fontSize: isMobile ? 32 : 40,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF00FF00),
                                    letterSpacing: 1.1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                                Consumer3<
                                  DadosPessoaisController,
                                  CaracteristicasFisicasController,
                                  LocalizacaoController
                                >(
                                  builder:
                                      (
                                        context,
                                        dadosPessoais,
                                        caracteristicas,
                                        localizacao,
                                        _,
                                      ) => Consumer<JogadorController>(
                                        builder: (context, jogadorCtrl, _) =>
                                            JogadorTecnicoCard(
                                              nome: dadosPessoais.nome,
                                              apelido: dadosPessoais.apelido,
                                              fotoUrl:
                                                  _imagemPerfil?.path ?? '',
                                              nacionalidade:
                                                  localizacao.nacionalidade ??
                                                  '',
                                              overall: 50,
                                              nivel: 0,
                                              posicaoPrincipal:
                                                  jogadorCtrl
                                                      .posicaoPrincipal ??
                                                  '',
                                              posicoesSecundarias: jogadorCtrl
                                                  .posicoesSecundarias
                                                  .toList(),
                                              peDominante:
                                                  caracteristicas.peDominante ??
                                                  '',
                                              altura:
                                                  double.tryParse(
                                                    caracteristicas.altura ??
                                                        '0',
                                                  ) ??
                                                  0,
                                              peso:
                                                  double.tryParse(
                                                    caracteristicas.peso ?? '0',
                                                  ) ??
                                                  0,
                                              escudoClube: '',
                                              tipoPerfil: 'Jogador',
                                              niveis: jogadorCtrl.niveis
                                                  .toList(),
                                              badges: jogadorCtrl
                                                  .badgesSelecionadas
                                                  .toList(),
                                              estilosTaticos: const [],
                                              niveisQueTreina: const [],
                                              experiencia: '',
                                              disponibilidade: '',
                                              exibirEscolherFoto: true,
                                              onSelecionarFoto:
                                                  _selecionarImagem,
                                              dataNascimento: dadosPessoais
                                                  .calendarioController
                                                  .dataDateTime, // <-- ADICIONE!
                                              estado:
                                                  localizacao.estado ??
                                                  '', // <-- ADICIONE se quiser bandeira do estado depois!
                                            ),
                                      ),
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
                                    child:
                                        Consumer3<
                                          DadosPessoaisController,
                                          CaracteristicasFisicasController,
                                          LocalizacaoController
                                        >(
                                          builder:
                                              (
                                                context,
                                                dadosPessoais,
                                                caracteristicas,
                                                localizacao,
                                                _,
                                              ) => Consumer<JogadorController>(
                                                builder:
                                                    (
                                                      context,
                                                      jogadorCtrl,
                                                      _,
                                                    ) => JogadorTecnicoCard(
                                                      nome: dadosPessoais.nome,
                                                      apelido:
                                                          dadosPessoais.apelido,
                                                      fotoUrl: '',
                                                      nacionalidade:
                                                          localizacao
                                                              .nacionalidade ??
                                                          '',
                                                      overall: 50,
                                                      nivel: 0,
                                                      posicaoPrincipal:
                                                          jogadorCtrl
                                                              .posicaoPrincipal ??
                                                          '',
                                                      posicoesSecundarias:
                                                          jogadorCtrl
                                                              .posicoesSecundarias
                                                              .toList(),
                                                      peDominante:
                                                          caracteristicas
                                                              .peDominante ??
                                                          '',
                                                      altura:
                                                          double.tryParse(
                                                            caracteristicas
                                                                    .altura ??
                                                                '0',
                                                          ) ??
                                                          0,
                                                      peso:
                                                          double.tryParse(
                                                            caracteristicas
                                                                    .peso ??
                                                                '0',
                                                          ) ??
                                                          0,
                                                      escudoClube: '',
                                                      tipoPerfil: 'Jogador',
                                                      niveis: jogadorCtrl.niveis
                                                          .toList(),
                                                      badges: jogadorCtrl
                                                          .badgesSelecionadas
                                                          .toList(),
                                                      estilosTaticos: const [],
                                                      niveisQueTreina: const [],
                                                      experiencia: '',
                                                      disponibilidade: '',
                                                    ),
                                              ),
                                        ),
                                  ),
                                ),
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
          ],
        ),
      ),
    );
  }

  Widget _formularioCadastro(bool isMobile) {
    return Consumer4<
      DadosPessoaisController,
      CaracteristicasFisicasController,
      LocalizacaoController,
      JogadorController
    >(
      builder: (context, dadosPessoais, caracteristicas, localizacao, jogadorCtrl, _) {
        return Form(
          key: jogadorCtrl.formKey,
          child: Column(
            crossAxisAlignment: isMobile
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              TituloSecao('Dados Pessoais', Icons.account_circle, isMobile),
              CampoTexto(
                controller: dadosPessoais.nomeCtrl,
                label: 'Nome Completo',
                icon: Icons.person,
                hint: "Ex: João Silva",
                validator: Validadores.validaNome,
                onChanged: dadosPessoais.setNome,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: dadosPessoais.apelidoCtrl,
                label: 'Apelido',
                icon: Icons.face,
                hint: "Ex: Zico, Bebeto, etc.",
                validator: Validadores.validaApelido,
                onChanged: dadosPessoais.setApelido,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: dadosPessoais.emailCtrl,
                label: 'Email',
                icon: Icons.email,
                hint: "Ex: seu@gmail.com",
                validator: Validadores.validaEmail,
                onChanged: dadosPessoais.setEmail,
              ),
              const SizedBox(height: 16),
              CampoData(
                controller: dadosPessoais.dataNascimentoCtrl,
                label: 'Data de Nascimento',
                icon: Icons.cake,
                validator: Validadores.validaNascimento,
                onChanged: dadosPessoais.setDataNascimento,
                onCalendario: () async {
                  await dadosPessoais.calendarioController.escolherData(
                    context,
                  );
                  // Atualiza a data no controller de dados pessoais após seleção
                  dadosPessoais.setDataNascimento(
                    dadosPessoais.calendarioController.data,
                  );
                },
              ),
              const SizedBox(height: 16),
              CampoSenha(
                controller: dadosPessoais.senhaCtrl,
                label: 'Senha',
                icon: Icons.lock,
                mostrar: jogadorCtrl.mostrarSenha,
                onMostrar: jogadorCtrl.toggleMostrarSenha,
                validator: Validadores.validaSenha,
                classificaForcaSenha: Validadores.classificaForcaSenha,
                corForcaSenha: Validadores.corForcaSenha,
                onChanged: dadosPessoais.setSenha,
              ),
              const SizedBox(height: 16),
              CampoSenha(
                controller: dadosPessoais.confirmarSenhaCtrl,
                label: 'Confirmar Senha',
                icon: Icons.lock,
                mostrar: jogadorCtrl.mostrarConfSenha,
                onMostrar: jogadorCtrl.toggleMostrarConfSenha,
                validator: (v) =>
                    Validadores.validaConfirmarSenha(v, dadosPessoais.senha),
                classificaForcaSenha: (v) {
                  final senha = dadosPessoais.senha;
                  if (v != senha) return "Senhas não conferem";
                  return Validadores.classificaForcaSenha(v ?? '');
                },
                corForcaSenha: (v) {
                  final senha = dadosPessoais.senha;
                  if (v != senha) return Colors.red;
                  return Validadores.corForcaSenha(v ?? '');
                },
                onChanged: dadosPessoais.setConfirmarSenha,
              ),
              const SizedBox(height: 12),

              TituloSecao(
                "Características Físicas",
                Icons.fitness_center,
                isMobile,
              ),
              CampoTexto(
                controller: caracteristicas.alturaCtrl,
                label: 'Altura (cm)',
                icon: Icons.height,
                hint: "Ex: 175",
                keyboardType: TextInputType.number,
                validator: Validadores.validaAltura,
                onChanged: caracteristicas.setAltura,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: caracteristicas.pesoCtrl,
                label: 'Peso (kg)',
                icon: Icons.monitor_weight,
                hint: "Ex: 70.5",
                keyboardType: TextInputType.number,
                validator: Validadores.validaPeso,
                onChanged: caracteristicas.setPeso,
              ),
              const SizedBox(height: 12),

              TituloSecao("Pé Dominante", Icons.directions_walk, isMobile),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  BotaoPe(
                    texto: "Destro",
                    icone: Icons.directions_run,
                    selecionado: caracteristicas.peDominante == "Destro",
                    onPressed: () => caracteristicas.setPeDominante("Destro"),
                  ),
                  const SizedBox(height: 12),
                  BotaoPe(
                    texto: "Canhoto",
                    icone: Icons.directions_walk,
                    selecionado: caracteristicas.peDominante == "Canhoto",
                    onPressed: () => caracteristicas.setPeDominante("Canhoto"),
                  ),
                  const SizedBox(height: 12),
                  BotaoPe(
                    texto: "Ambidestro",
                    icone: Icons.accessibility_new,
                    selecionado: caracteristicas.peDominante == "Ambidestro",
                    onPressed: () =>
                        caracteristicas.setPeDominante("Ambidestro"),
                  ),
                ],
              ),
              if (jogadorCtrl.validando &&
                  (caracteristicas.peDominante == null ||
                      caracteristicas.peDominante!.isEmpty))
                const Padding(
                  padding: EdgeInsets.only(top: 4, left: 5),
                  child: Text(
                    "Escolha o pé dominante",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              const SizedBox(height: 12),

              TituloSecao("Localização", Icons.location_on, isMobile),
              const SizedBox(height: 3),
              NacionalidadeDropdown(
                value: localizacao.nacionalidade,
                onChanged: (String? value) {
                  if (value != null) {
                    localizacao.setNacionalidade(value);
                  }
                },
              ),
              const SizedBox(height: 20),
              EstadoDropdown(
                value: (localizacao.estado?.isEmpty ?? true)
                    ? "RS"
                    : localizacao.estado,
                onChanged: localizacao.setEstado,
                label: 'Estado',
                obrigatorio: true,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: localizacao.cidadeCtrl,
                label: "Cidade",
                icon: Icons.location_city,
                obrigatorio: true,
                hint: "Nome da sua cidade",
                validator: Validadores.validaCampoObrigatorio,
                onChanged: localizacao.setCidade,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: localizacao.cepCtrl,
                label: 'CEP',
                icon: Icons.pin_drop,
                keyboardType: TextInputType.number,
                hint: '00000-000',
                validator: Validadores.validaCampoObrigatorio,
                onChanged: localizacao.setCep,
              ),
              const SizedBox(height: 16),
              CampoTexto(
                controller: localizacao.bairroCtrl,
                label: 'Bairro',
                icon: Icons.home_outlined,
                hint: "Nome do seu bairro",
                validator: Validadores.validaCampoObrigatorio,
                onChanged: localizacao.setBairro,
              ),
              const SizedBox(height: 12),

              TituloSecao(
                "Níveis de Jogo (Máx: 3)",
                Icons.emoji_events,
                isMobile,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: NiveisJogadorSelector(
                  selecionados: jogadorCtrl.niveis, // Set<String>
                  onChanged: jogadorCtrl.setNiveis,
                ),
              ),
              const SizedBox(height: 12),
              TituloSecao("Posições Preferidas", Icons.sports, isMobile),
              Text(
                "Selecione 1 principal (ouro) e até 3 secundárias (pratas)",
                style: TextStyle(
                  color: Colors.white.withOpacity(0.86),
                  fontSize: isMobile ? 17 : 19,
                ),
              ),
              const SizedBox(height: 20),
              CampinhoFUT7(
                posicoes: posicoesCampo,
                principal: jogadorCtrl.posicaoPrincipal,
                secundarias: jogadorCtrl.posicoesSecundarias,
                onSelect: (nome) {
                  final setSec = Set<String>.from(
                    jogadorCtrl.posicoesSecundarias,
                  );

                  // Se clicou na principal, desmarca principal
                  if (jogadorCtrl.posicaoPrincipal == nome) {
                    jogadorCtrl.setPosicaoPrincipal('');
                    return;
                  }

                  // Se clicou numa que é secundária
                  if (setSec.contains(nome)) {
                    // Vira principal, sai de secundária
                    setSec.remove(nome);
                    jogadorCtrl.setPosicoesSecundarias(setSec);
                    jogadorCtrl.setPosicaoPrincipal(nome);
                    return;
                  }

                  // Se não tem principal ainda, vira principal
                  if (jogadorCtrl.posicaoPrincipal == null ||
                      jogadorCtrl.posicaoPrincipal!.isEmpty) {
                    jogadorCtrl.setPosicaoPrincipal(nome);
                    return;
                  }

                  // Se já existe principal (e clicou em outra), tenta adicionar/remover como secundária
                  if (!setSec.contains(nome)) {
                    if (setSec.length < 3) {
                      setSec.add(nome);
                      jogadorCtrl.setPosicoesSecundarias(setSec);
                    }
                  } else {
                    setSec.remove(nome);
                    jogadorCtrl.setPosicoesSecundarias(setSec);
                  }
                },
              ),
              BancoReservasFUT7(
                onSelect: (idx) {
                  setState(() {});
                },
                selecionado: null,
              ),
              const SizedBox(height: 12),

              BotaoCriarConta(
                onPressed: () async {
                  // Copia todos os campos do formulário visual para o controller!
                  jogadorCtrl.setNome(dadosPessoais.nomeCtrl.text);
                  jogadorCtrl.setApelido(dadosPessoais.apelidoCtrl.text);
                  jogadorCtrl.setEmail(
                    dadosPessoais.emailCtrl.text.trim().toLowerCase(),
                  );

                  jogadorCtrl.setSenha(dadosPessoais.senhaCtrl.text);
                  jogadorCtrl.setConfirmarSenha(
                    dadosPessoais.confirmarSenhaCtrl.text,
                  );
                  jogadorCtrl.setDataNascimento(
                    dadosPessoais.dataNascimentoCtrl.text,
                  );

                  jogadorCtrl.setAltura(caracteristicas.alturaCtrl.text);
                  jogadorCtrl.setPeso(caracteristicas.pesoCtrl.text);
                  jogadorCtrl.setPeDominante(caracteristicas.peDominante);

                  jogadorCtrl.setNacionalidade(localizacao.nacionalidade);
                  jogadorCtrl.setEstado(localizacao.estado);
                  jogadorCtrl.setCidade(localizacao.cidadeCtrl.text);
                  jogadorCtrl.setBairro(localizacao.bairroCtrl.text);
                  jogadorCtrl.setCep(localizacao.cepCtrl.text);

                  // Agora sim!
                  await jogadorCtrl.cadastrar(context);

                  setState(() => jogadorCtrl.validando = true);
                },
                isMobile: isMobile,
              ),

              const SizedBox(height: 20),
              BotaoLogin(
                onPressed: () => Navigator.pushNamed(context, '/'),
                isMobile: isMobile,
              ),
              const SizedBox(height: 20),
              BotaoVoltar(onPressed: () => Navigator.pop(context)),
              const SizedBox(height: 6),
            ],
          ),
        );
      },
    );
  }
}
