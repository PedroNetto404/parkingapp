import 'package:flutter/material.dart';

class AppTheme {
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF1F1F1F),
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF5722),
      brightness: Brightness.dark,
    ).copyWith(
      surface: const Color(0xFF2C2C2C),
      onSurface: Colors.white,
      error: const Color(0xFFCF6679),
      onError: Colors.black,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold),
      displayMedium: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 28,
          fontWeight: FontWeight.bold),
      displaySmall: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold),
      headlineSmall: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold),
      titleLarge: TextStyle(
          fontFamily: 'Roboto',
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold),
      bodyLarge: TextStyle(
          fontFamily: 'Roboto', color: Color(0xFFB0B0B0), fontSize: 14),
      bodyMedium: TextStyle(
          fontFamily: 'Roboto', color: Color(0xFFB0B0B0), fontSize: 12),
      labelLarge:
          TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 16),
      labelSmall:
          TextStyle(fontFamily: 'Roboto', color: Colors.white, fontSize: 14),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1F1F1F),
      titleTextStyle: TextStyle(
          color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Color(0xFFFF5722),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF5722),
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFFFF5722),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: Color(0xFF2C2C2C),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFF3D3D3D)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        borderSide: BorderSide(color: Color(0xFFFF5722)),
      ),
      labelStyle: TextStyle(color: Color(0xFFB0B0B0)),
      hintStyle: TextStyle(color: Color(0xFFB0B0B0)),
    ),
  );
}
