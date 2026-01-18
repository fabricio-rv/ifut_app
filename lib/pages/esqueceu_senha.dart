import 'package:flutter/material.dart';
import 'widgets/botoes/botao_voltar.dart';
import 'widgets/botoes/botao_continuar.dart';
import 'widgets/campos/campo_texto.dart';

class EsqueceuSenhaPage extends StatelessWidget {
  const EsqueceuSenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;
    final TextEditingController emailCtrl = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/fundo_estadio.png", fit: BoxFit.cover),
          Container(color: Colors.black.withOpacity(0.40)),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 44,
                  vertical: isMobile ? 18 : 40,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Ícone chave
                    Icon(
                      Icons.vpn_key,
                      size: isMobile ? 60 : 80,
                      color: const Color(0xFF00FF00),
                    ),
                    const SizedBox(height: 16),
                    // Título
                    Text(
                      "Recuperar Senha",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 34 : 48,
                        fontWeight: FontWeight.w900,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    // Subtítulo
                    Text(
                      "Digite seu email para começar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: isMobile ? 19 : 24,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    // Linha de progresso (decorativa)
                    SizedBox(
                      width: double.infinity,
                      child: Stack(
                        alignment: Alignment.centerLeft,
                        children: [
                          Container(
                            height: 5,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.65),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          FractionallySizedBox(
                            widthFactor: 0.22,
                            child: Container(
                              height: 5,
                              decoration: BoxDecoration(
                                color: const Color(0xFF00FF00),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Label Email
                    SizedBox(
                      width: isMobile ? double.infinity : 1600,
                      child: CampoTexto(
                        controller:
                            emailCtrl, // Defina o controller localmente no seu widget/page
                        label: 'Email',
                        icon: Icons.email,
                        hint: "Ex: seu@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) {
                          // Validação simples (pode trocar se quiser)
                          if (v == null || v.isEmpty)
                            return "Digite seu e-mail";
                          if (!v.contains('@')) return "E-mail inválido";
                          return null;
                        },
                        onChanged: (v) {}, // Ou seu método preferido
                      ),
                    ),
                    const SizedBox(height: 25),

                    // Botão CONTINUAR (custom widget)
                    BotaoContinuar(
                      isMobile: isMobile,
                      onPressed: () {
                        // callback submit
                      },
                    ),

                    const SizedBox(height: 25),

                    // Botão Voltar ao Login (usando widget padrão)
                    BotaoVoltar(
                      isMobile: isMobile,
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
