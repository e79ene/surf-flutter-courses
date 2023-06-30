import 'package:flutter/material.dart';

const _green = Color(0xFF67CD00);

final themeData = ThemeData(
  fontFamily: 'Sora',
  colorScheme: ColorScheme.fromSeed(
    seedColor: _green,
    primary: _green,
    secondary: _green,
  ),
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    foregroundColor: Color(0xFF252849),
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(
      color: _green,
      size: 18,
    ),
  ),
  actionIconTheme: ActionIconThemeData(
    backButtonIconBuilder: (context) => const Icon(Icons.arrow_back_ios),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 14),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
);
