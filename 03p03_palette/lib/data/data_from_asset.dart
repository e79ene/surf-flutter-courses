import 'dart:convert';

import 'package:flutter/services.dart';

import '../model/color_sample.dart';
import 'i_data.dart';

class DataFromAsset implements IData {
  final AssetBundle assetBundle;
  final String assetKey;

  DataFromAsset(this.assetBundle, this.assetKey);

  @override
  Future<List<ColorSample>> getColorSamples() async {
    final jsonData = jsonDecode(await assetBundle.loadString(assetKey));
    return (jsonData['colors'] as List)
        .where(
            (jsonColor) => (jsonColor['value'] as String?)?.isNotEmpty ?? false)
        .map((jsonColor) =>
            ColorSample(jsonColor['name']!, _parseColor(jsonColor['value']!)))
        .toList();
  }

  Color _parseColor(String string) {
    var hexColor = string.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }

    throw FormatException("Wrong color format", string);
  }
}
