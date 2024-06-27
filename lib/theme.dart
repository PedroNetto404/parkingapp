import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData theme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF1E3A8A),
    scaffoldBackgroundColor: const Color(0xFFF3F4F6),
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E3A8A),
      primary: const Color(0xFF1E3A8A),
      secondary: const Color(0xFFFF5722),
      background: const Color(0xFFF3F4F6),
      surface: const Color(0xFFFFFFFF),
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: const Color(0xFF1E3A8A),
      onSurface: const Color(0xFF2C2C2C),
      error: const Color(0xFFCF6679),
      onError: Colors.black,
    ),
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 32,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 28,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF2C2C2C),
        fontSize: 14,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF2C2C2C),
        fontSize: 12,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 16,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Roboto',
        color: Color(0xFF1E3A8A),
        fontSize: 14,
      ),
    ),
    appBarTheme: const AppBarTheme(
      color: Color(0xFF1E3A8A),
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
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
      fillColor: Color(0xFFE0E0E0),
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
      labelStyle: TextStyle(color: Color(0xFF2C2C2C)),
      hintStyle: TextStyle(color: Color(0xFF2C2C2C)),
    ),
  );
}
