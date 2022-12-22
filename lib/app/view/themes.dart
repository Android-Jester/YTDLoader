import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.brown[400],
      appBarTheme: const AppBarTheme(
        shape: RoundedRectangleBorder(),
      ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: Colors.brown[200],
      brightness: Brightness.dark,
    );
  }
}
