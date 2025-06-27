import 'package:flutter/material.dart';

class EsqueceuSenhaPage extends StatelessWidget {
  const EsqueceuSenhaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 700;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 44,
              vertical: isMobile ? 18 : 40,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // ícone chave
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
                const SizedBox(height: 12),
                // Subtítulo
                Text(
                  "Digite seu email para começar",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.82),
                    fontSize: isMobile ? 19 : 24,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Linha de progresso (decorativa)
                SizedBox(
                  width: double.infinity,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 5,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.15),
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
                const SizedBox(height: 30),

                // Label Email
                Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(
                        Icons.email,
                        size: 20,
                        color: const Color(0xFF00FF00),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Email",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: isMobile ? 18 : 21,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),

                // Campo Email
                TextField(
                  style: const TextStyle(color: Colors.white),
                  cursorColor: const Color(0xFF00FF00),
                  decoration: InputDecoration(
                    hintText: "seu@gmail.com",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.65)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Color(0xFF00FF00)),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color(0xFF00FF00),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(9),
                    ),
                    fillColor: Colors.transparent,
                    filled: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 18,
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 32),

                // Botão CONTINUAR
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // callback submit
                    },
                    icon: Icon(Icons.arrow_forward, color: Colors.black),
                    label: Text(
                      "CONTINUAR",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 20 : 24,
                        letterSpacing: 1.1,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00FF00),
                      elevation: 8,
                      padding: EdgeInsets.symmetric(
                        vertical: isMobile ? 18 : 22,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                // Botão Voltar ao Login
                Align(
                  alignment: Alignment.center,
                  child: TextButton.icon(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white70,
                      size: 22,
                    ),
                    label: Text(
                      "Voltar ao Login",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.85),
                        fontSize: isMobile ? 18 : 20,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
