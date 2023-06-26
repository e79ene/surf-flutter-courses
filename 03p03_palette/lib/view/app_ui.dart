import 'package:flutter/material.dart';

import '../data/i_data.dart';
import 'color_grid_screen.dart';
import 'i_app_ui.dart';

class AppUI implements IAppUI {
  final IData data;

  AppUI({required this.data});

  @override
  void start() {
    runApp(_MainApp(
      data: data,
    ));
  }
}

const _foregroundColor = Color(0xFF252838);

final _themeData = ThemeData(
  fontFamily: 'Ubuntu',
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    foregroundColor: _foregroundColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: _foregroundColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
      height: 1.1,
      letterSpacing: -0.60,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      padding: const EdgeInsets.symmetric(vertical: 27, horizontal: 16),
      backgroundColor: Colors.white,
      foregroundColor: _foregroundColor,
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  ),
);

class _MainApp extends StatelessWidget {
  final IData data;

  const _MainApp({
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      home: ColorGridScreen(data: data),
    );
  }
}
