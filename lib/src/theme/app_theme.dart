import 'package:flutter/material.dart';

class AppTheme {
  static const navy = Color(0xFF10243A);
  static const blue = Color(0xFF176B87);
  static const teal = Color(0xFF2A9D8F);
  static const background = Color(0xFFF3F6F8);
  static const muted = Color(0xFF6B7C8F);
  static const orange = Color(0xFFE89B36);
  static const red = Color(0xFFD9534F);

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: background,
    colorScheme: ColorScheme.fromSeed(seedColor: blue, primary: blue, surface: Colors.white),
    appBarTheme: const AppBarTheme(backgroundColor: background, foregroundColor: navy, elevation: 0),
    cardTheme: CardThemeData(color: Colors.white, elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
    ),
  );
}
