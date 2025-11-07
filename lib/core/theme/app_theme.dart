import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary =Color.fromARGB(255, 180, 136, 127);
  static const Color accent = Color(0xFFFFD700);
  static const Color background = Color(0xFFF8F9FA);
  static const Color textPrimary = Color(0xFF212121);

  static ThemeData get lightTheme {
    return ThemeData(
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        primary: primary,
        secondary: accent,
        background: background,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 16,
          color: textPrimary,
        ),
      ),
      useMaterial3: true,
    );
  }
}
