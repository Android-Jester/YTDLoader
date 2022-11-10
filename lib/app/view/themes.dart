import 'package:flutter/material.dart';

class Themes {
  static ThemeData lightTheme() {
    const lightColorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF006A66),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF70F7F0),
      onPrimaryContainer: Color(0xFF00201F),
      secondary: Color(0xFF6B5F00),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFF8E467),
      onSecondaryContainer: Color(0xFF201C00),
      tertiary: Color(0xFFB90063),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFFFD9E2),
      onTertiaryContainer: Color(0xFF3E001D),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFFAFDFB),
      onBackground: Color(0xFF191C1C),
      surface: Color(0xFFFAFDFB),
      onSurface: Color(0xFF191C1C),
      surfaceVariant: Color(0xFFDAE5E3),
      onSurfaceVariant: Color(0xFF3F4948),
      outline: Color(0xFF6F7978),
      onInverseSurface: Color(0xFFEFF1F0),
      inverseSurface: Color(0xFF2D3131),
      inversePrimary: Color(0xFF4EDAD4),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF006A66),
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightColorScheme,
      backgroundColor: lightColorScheme.background,
      scaffoldBackgroundColor: lightColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: lightColorScheme.secondary,
        shape: const RoundedRectangleBorder(),
      ),
    );
  }

  static ThemeData darkTheme() {
    const darkColorScheme = ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xFF4EDAD4),
      onPrimary: Color(0xFF003735),
      primaryContainer: Color(0xFF00504D),
      onPrimaryContainer: Color(0xFF70F7F0),
      secondary: Color(0xFFDBC84E),
      onSecondary: Color(0xFF373100),
      secondaryContainer: Color(0xFF504700),
      onSecondaryContainer: Color(0xFFF8E467),
      tertiary: Color(0xFFFFB1C8),
      onTertiary: Color(0xFF650033),
      tertiaryContainer: Color(0xFF8E004A),
      onTertiaryContainer: Color(0xFFFFD9E2),
      error: Color(0xFFFFB4AB),
      errorContainer: Color(0xFF93000A),
      onError: Color(0xFF690005),
      onErrorContainer: Color(0xFFFFDAD6),
      background: Color(0xFF191C1C),
      onBackground: Color(0xFFE0E3E2),
      surface: Color(0xFF191C1C),
      onSurface: Color(0xFFE0E3E2),
      surfaceVariant: Color(0xFF3F4948),
      onSurfaceVariant: Color(0xFFBEC9C7),
      outline: Color(0xFF889391),
      onInverseSurface: Color(0xFF191C1C),
      inverseSurface: Color(0xFFE0E3E2),
      inversePrimary: Color(0xFF006A66),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF4EDAD4),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: darkColorScheme,
      backgroundColor: darkColorScheme.background,
      scaffoldBackgroundColor: darkColorScheme.background,
      appBarTheme: AppBarTheme(
        backgroundColor: darkColorScheme.secondary,
        shape: const RoundedRectangleBorder(),
      ),
    );
  }
}
