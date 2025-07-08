import 'package:flutter/material.dart';
import 'dart:ui';

class ConfigPage extends StatelessWidget {
  const ConfigPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
              vertical: size.height * 0.03,
            ),
            children: [
              // Cabeçalho com botão de voltar
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(Icons.arrow_back, color: Colors.white),
                    ),
                  ),
                  SizedBox(width: 20),
                  Text(
                    'CONFIGURAÇÕES',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),

              // Seção: Conta
              _buildSectionTitle('CONTA'),
              _buildConfigItem(
                icon: Icons.person,
                title: 'Informações Pessoais',
                subtitle: 'Nome, data de nascimento, gênero',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.email,
                title: 'Alterar Email',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.lock,
                title: 'Alterar Senha',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.phone,
                title: 'Número de Telefone',
                subtitle: 'Adicionar ou alterar',
                onTap: () {},
              ),
              SizedBox(height: size.height * 0.02),

              // Seção: Privacidade
              _buildSectionTitle('PRIVACIDADE'),
              _buildConfigItem(
                icon: Icons.visibility,
                title: 'Visibilidade do Perfil',
                subtitle: 'Quem pode ver suas informações',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.notifications,
                title: 'Notificações',
                subtitle: 'Personalizar alertas',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.block,
                title: 'Contas Bloqueadas',
                onTap: () {},
              ),
              SizedBox(height: size.height * 0.02),

              // Seção: Dados
              _buildSectionTitle('DADOS'),
              _buildConfigItem(
                icon: Icons.security,
                title: 'Segurança da Conta',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.storage,
                title: 'Armazenamento de Dados',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.delete,
                title: 'Excluir Conta',
                subtitle: 'Remover permanentemente',
                isDestructive: true,
                onTap: () {},
              ),
              SizedBox(height: size.height * 0.02),

              // Seção: App
              _buildSectionTitle('APLICATIVO'),
              _buildConfigItem(
                icon: Icons.language,
                title: 'Idioma',
                subtitle: 'Português (Brasil)',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.dark_mode,
                title: 'Tema Escuro',
                subtitle: 'Ativado',
                trailing: Switch(
                  value: true,
                  activeColor: Colors.greenAccent,
                  onChanged: (value) {},
                ),
                onTap: null,
              ),
              _buildConfigItem(
                icon: Icons.help,
                title: 'Ajuda e Suporte',
                onTap: () {},
              ),
              _buildConfigItem(
                icon: Icons.info,
                title: 'Sobre o App',
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.greenAccent,
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildConfigItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    bool isDestructive = false,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isDestructive
                  ? Colors.red.withOpacity(0.2)
                  : Colors.greenAccent.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isDestructive ? Colors.red : Colors.greenAccent,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              color: isDestructive ? Colors.red : Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                )
              : null,
          trailing:
              trailing ?? Icon(Icons.chevron_right, color: Colors.white54),
          onTap: onTap,
          contentPadding: EdgeInsets.symmetric(vertical: 4),
        ),
        Divider(height: 1, color: Colors.white.withOpacity(0.1)),
      ],
    );
  }
}

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/fundo_estadio.png', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Container(color: Colors.black.withOpacity(0.6)),
          ),
        ),
        child,
      ],
    );
  }
}
