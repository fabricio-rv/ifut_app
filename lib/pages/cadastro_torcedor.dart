// pages/cadastro_torcedor.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import 'controllers/torcedor_controller.dart';
import 'controllers/calendario_controller.dart';
import 'models/cadastro_torcedor_model.dart';
import 'widgets/dropdown/nacionalidade.dart';
import 'widgets/dropdown/dropdown_estado.dart';
import 'widgets/dropdown/clubes_select.dart';
import 'widgets/atributos/notificacoes.dart';
import 'widgets/botoes/botao_criar_conta.dart';
import 'widgets/botoes/botao_voltar.dart';
import 'widgets/campos/titulo_secao.dart';
import 'widgets/campos/campo_texto.dart';
import 'widgets/campos/campo_senha.dart';
import 'widgets/campos/campo_data.dart';
import 'utils/validadores.dart';
import 'widgets/botoes/botao_login.dart';
import 'widgets/dropdown/calendario.dart';

class CadastroPageState extends State<CadastroTorcedorPage> {
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

class CadastroTorcedorPage extends StatefulWidget {
  const CadastroTorcedorPage({super.key});

  @override
  State<CadastroTorcedorPage> createState() => _CadastroTorcedorPageState();
}

class _CadastroTorcedorPageState extends State<CadastroTorcedorPage> {
  final _formKey = GlobalKey<FormState>();
  final torcedorCtrl = TorcedorController();

  bool _mostrarSenha = false;
  bool _mostrarConfSenha = false;
  bool _validando = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return ChangeNotifierProvider(
      create: (_) => TorcedorController(),
      child: Consumer<TorcedorController>(
        builder: (context, controller, _) {
          return Scaffold(
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
                        child: Form(
                          key: controller.formKey,
                          autovalidateMode: _validando
                              ? AutovalidateMode.always
                              : AutovalidateMode.disabled,
                          child: Column(
                            crossAxisAlignment: isMobile
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 14),
                              Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Cadastro de Torcedor',
                                      style: TextStyle(
                                        fontSize: isMobile ? 30 : 36,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFF00FF00),
                                        letterSpacing: 1.1,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 16),
                                  ],
                                ),
                              ),
                              // Dados Pessoais
                              TituloSecao(
                                'Dados Pessoais',
                                Icons.account_circle,
                                isMobile,
                              ),
                              CampoTexto(
                                controller: controller.nomeCtrl,
                                label: "Nome",
                                icon: Icons.person,
                                hint: "Ex: João Silva",
                                validator: controller.validarNome,
                                onChanged: (value) =>
                                    controller.nomeCtrl.text = value,
                              ),
                              const SizedBox(height: 16),

                              CampoTexto(
                                controller: controller.apelidoCtrl,
                                label: "Apelido",
                                icon: Icons.face,
                                hint: "Nome de Exibição no App.",
                                validator: controller.validarApelido,
                                onChanged: (value) =>
                                    controller.apelidoCtrl.text = value,
                              ),
                              const SizedBox(height: 16),

                              CampoTexto(
                                controller: controller.emailCtrl,
                                label: "E-mail",
                                icon: Icons.email,
                                hint: "Ex: seu@gmail.com",
                                keyboardType: TextInputType.emailAddress,
                                validator: controller.validarEmail,
                                onChanged: (value) =>
                                    controller.emailCtrl.text = value,
                              ),
                              const SizedBox(height: 16),

                              DropdownClubes(
                                value: controller.timeCoracao,
                                onChanged: (val) {
                                  controller.setTimeCoracao(
                                    val,
                                  ); // para atualizar a UI se necessário
                                },
                              ),
                              const SizedBox(height: 16),

                              CampoData(
                                controller: controller.dataNascimentoCtrl,
                                label: 'Data de Nascimento',
                                icon: Icons.cake,
                                validator: controller.validarDataNascimento,
                                onChanged: controller.setDataNascimento,
                                onCalendario: () async {
                                  DateTime? picked = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime(1980),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime.now(),
                                    builder: (context, child) {
                                      return Theme(
                                        data: ThemeData.dark().copyWith(
                                          colorScheme: const ColorScheme.dark(
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
                                    final formattedDate = DateFormat(
                                      'dd/MM/yyyy',
                                    ).format(picked);
                                    controller.dataNascimentoCtrl.text =
                                        formattedDate;
                                    controller.setDataNascimento(formattedDate);
                                    // Se estiver em StatefulWidget, chame setState se necessário
                                  }
                                },
                              ),
                              const SizedBox(height: 16),

                              CampoSenha(
                                controller: controller.senhaCtrl,
                                label: 'Senha',
                                icon: Icons.lock,
                                mostrar: _mostrarSenha,
                                onMostrar: () => setState(
                                  () => _mostrarSenha = !_mostrarSenha,
                                ),
                                validator: controller.validarSenha,
                                classificaForcaSenha:
                                    Validadores.classificaForcaSenha,
                                corForcaSenha: Validadores.corForcaSenha,
                                onChanged: (v) => controller.setSenha(v),
                              ),
                              const SizedBox(height: 16),

                              CampoSenha(
                                controller: controller.confirmarSenhaCtrl,
                                label: 'Confirmar Senha',
                                icon: Icons.lock,
                                mostrar: _mostrarConfSenha,
                                onMostrar: () => setState(
                                  () => _mostrarConfSenha = !_mostrarConfSenha,
                                ),
                                validator: (v) =>
                                    controller.validarConfirmarSenha(v),
                                classificaForcaSenha: (v) {
                                  final senha = controller.senhaCtrl.text;
                                  if (v != senha) return "Senhas não conferem";
                                  return Validadores.classificaForcaSenha(
                                    v ?? '',
                                  );
                                },
                                corForcaSenha: (v) {
                                  final senha = controller.senhaCtrl.text;
                                  if (v != senha) return Colors.red;
                                  return Validadores.corForcaSenha(v ?? '');
                                },
                                onChanged: (v) =>
                                    controller.setConfirmarSenha(v),
                              ),
                              const SizedBox(height: 20),

                              TituloSecao(
                                "Localização",
                                Icons.location_on,
                                isMobile,
                              ),
                              const SizedBox(height: 3),

                              NacionalidadeDropdown(
                                value: controller.nacionalidade,
                                onChanged: controller.setNacionalidade,
                              ),
                              const SizedBox(height: 16),

                              EstadoDropdown(
                                value: (controller.estado?.isEmpty ?? true)
                                    ? "RS"
                                    : controller.estado,
                                onChanged: controller.setEstado,
                                label: 'Estado',
                                obrigatorio: true,
                              ),
                              const SizedBox(height: 16),

                              CampoTexto(
                                controller: controller.cidadeCtrl,
                                label: "Cidade",
                                icon: Icons.location_city,
                                validator: controller.validarCidade,
                                hint: "Nome da sua cidade",
                              ),
                              const SizedBox(height: 16),

                              CampoTexto(
                                controller: controller.cepCtrl,
                                label: 'CEP',
                                icon: Icons.map,
                                keyboardType: TextInputType.number,
                                hint: '00000-000',
                              ),
                              const SizedBox(height: 16),

                              CampoTexto(
                                controller: controller.bairroCtrl,
                                label: 'Bairro',
                                icon: Icons.home_outlined,
                                hint: "Nome do seu bairro",
                              ),
                              const SizedBox(height: 20),

                              Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: Text(
                                  "Preferência de notificações:",
                                  style: TextStyle(
                                    color: const Color(0xFF00FF00),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 25,
                                  ),
                                ),
                              ),

                              NotificacoesWidget(
                                notificacoes: controller.notificacoes,
                                onChanged: controller.setNotificacao,
                              ),

                              const SizedBox(height: 16),

                              BotaoCriarConta(
                                onPressed: () async {
                                  // Copia todos os campos do formulário visual para o controller
                                  controller.setNome(controller.nomeCtrl.text);
                                  controller.setApelido(
                                    controller.apelidoCtrl.text,
                                  );
                                  controller.setEmail(
                                    controller.emailCtrl.text
                                        .trim()
                                        .toLowerCase(),
                                  );
                                  controller.setSenha(
                                    controller.senhaCtrl.text,
                                  );
                                  controller.setConfirmarSenha(
                                    controller.confirmarSenhaCtrl.text,
                                  );
                                  controller.setDataNascimento(
                                    controller.dataNascimentoCtrl.text,
                                  );
                                  controller.setNacionalidade(
                                    controller.nacionalidade,
                                  );
                                  controller.setEstado(controller.estado ?? '');
                                  controller.setCidade(
                                    controller.cidadeCtrl.text,
                                  );
                                  controller.setBairro(
                                    controller.bairroCtrl.text,
                                  );
                                  controller.setCep(controller.cepCtrl.text);
                                  // Agora sim, chama o método para cadastrar no backend
                                  await controller.cadastrar(context);

                                  setState(() => controller.validando = true);
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
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
