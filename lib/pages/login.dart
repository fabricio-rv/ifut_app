// login.dart
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  bool senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.account_circle,
                size: isMobile ? 75 : 90,
                color: const Color(0xFF00FF00),
              ),
              const SizedBox(height: 16),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: isMobile ? 36 : 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Entre na sua conta',
                style: TextStyle(
                  fontSize: isMobile ? 19 : 24,
                  color: Colors.white.withOpacity(0.85),
                ),
              ),
              const SizedBox(height: 38),
              // Email
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 4),
                  child: Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 19 : 21,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'seu@gmail.com',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  prefixIcon: const Icon(Icons.email, color: Color(0xFF00FF00)),
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF00FF00)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF00FF00),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Senha
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 6, bottom: 4),
                  child: Text(
                    'Senha',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: isMobile ? 19 : 21,
                    ),
                  ),
                ),
              ),
              TextField(
                controller: senhaController,
                obscureText: !senhaVisivel,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Sua senha',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
                  prefixIcon: const Icon(Icons.lock, color: Color(0xFF00FF00)),
                  suffixIcon: IconButton(
                    icon: Icon(
                      senhaVisivel ? Icons.visibility : Icons.visibility_off,
                      color: const Color(0xFF00FF00),
                    ),
                    onPressed: () {
                      setState(() {
                        senhaVisivel = !senhaVisivel;
                      });
                    },
                  ),
                  filled: true,
                  fillColor: Colors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xFF00FF00)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Color(0xFF00FF00),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              // Botão ENTRAR
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00FF00),
                    foregroundColor: Colors.black,
                    shadowColor: const Color(0xFF00FF00),
                    elevation: 12,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    textStyle: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  icon: const Icon(Icons.login, color: Colors.black),
                  label: const Text('ENTRAR'),
                  onPressed: () {
                    // Adicione sua lógica de login aqui
                  },
                ),
              ),
              const SizedBox(height: 24),
              // Links
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/tipo_cadastro');
                },
                child: Text(
                  'Não tem conta? Cadastre-se',
                  style: TextStyle(
                    color: const Color(0xFF00FF00),
                    fontSize: isMobile ? 20 : 22,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/esqueceu_senha');
                },
                child: Text(
                  'Esqueceu a senha?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: isMobile ? 18 : 20,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
