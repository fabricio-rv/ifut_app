import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFF39FF14); // Verde neon
  static const Color background = Color(0xFF181818); // Preto quase puro

  static final ThemeData theme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: primaryGreen,
    scaffoldBackgroundColor: background,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: primaryGreen,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(color: Colors.white),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF1E1E1E),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryGreen, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryGreen, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: primaryGreen, width: 2.0),
      ),
      labelStyle: TextStyle(color: primaryGreen),
      hintStyle: TextStyle(color: Colors.white54),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        foregroundColor: Colors.black,
        minimumSize: const Size(double.infinity, 48),
        textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadowColor: primaryGreen,
        elevation: 8,
      ),
    ),
  );
}
