import 'dart:ui';

class ColorSample {
  final String name;
  final Color color;

  ColorSample(this.name, this.color);

  String get hex =>
      '#${color.value.toRadixString(16).substring(2, 8).toUpperCase()}';
}
