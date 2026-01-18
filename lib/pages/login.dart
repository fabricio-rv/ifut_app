import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/login_controller.dart';
import 'widgets/campos/campo_texto.dart';
import 'widgets/campos/campo_senha.dart';
import 'widgets/botoes/botao_criar_conta.dart';
import 'widgets/botoes/botao_login.dart'; // botão para logar
import 'widgets/botoes/botao_esqueceu_senha.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 700;

    return ChangeNotifierProvider(
      create: (_) => LoginController(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset("assets/fundo_estadio.png", fit: BoxFit.cover),
            Container(color: Colors.black.withOpacity(0.40)),
            SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: isMobile ? 4 : 0),
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: isMobile ? double.infinity : 1600,
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 28,
                      horizontal:
                          8, // menos padding horizontal para aumentar largura útil
                    ),
                    child: Consumer<LoginController>(
                      builder: (context, loginCtrl, _) => Form(
                        key: loginCtrl.formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: isMobile ? 75 : 90,
                              color: const Color(0xFF00FF00),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Login',
                              style: TextStyle(
                                fontSize: isMobile ? 36 : 48,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Entre na sua conta',
                              style: TextStyle(
                                fontSize: isMobile ? 19 : 24,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: isMobile ? double.infinity : 1600,
                              child: CampoTexto(
                                controller: loginCtrl.emailCtrl,
                                label: 'Email',
                                icon: Icons.email,
                                hint: "Ex: seu@gmail.com",
                                keyboardType: TextInputType.emailAddress,
                                validator: loginCtrl.validateEmail,
                                onChanged: loginCtrl.setEmail,
                              ),
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: isMobile ? double.infinity : 1600,
                              child: CampoSenha(
                                controller: loginCtrl.senhaCtrl,
                                label: 'Senha',
                                icon: Icons.lock,
                                mostrar: loginCtrl.senhaVisivel,
                                onMostrar: loginCtrl.toggleSenhaVisivel,
                                validator: loginCtrl.validateSenha,
                                onChanged: loginCtrl.setSenha,
                                classificaForcaSenha: null,
                                corForcaSenha: null,
                              ),
                            ),
                            const SizedBox(height: 18),
                            BotaoLogin(
                              onPressed: () async {
                                final success = await loginCtrl.login(context);
                                if (success) {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/menu_principal',
                                  );
                                }
                              },
                              isMobile: isMobile,
                            ),
                            const SizedBox(height: 18),
                            BotaoCriarConta(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/tipo_cadastro',
                              ),
                              isMobile: isMobile,
                            ),
                            const SizedBox(height: 18),
                            BotaoEsqueceuSenha(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/esqueceu_senha',
                              ),
                              isMobile: isMobile,
                            ),
                            const SizedBox(height: 6),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black, // opcional, mas stack já cobre tudo
      ),
    );
  }
}
