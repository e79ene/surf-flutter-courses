import 'package:flutter/services.dart';
import 'data/data_from_asset.dart';
import 'view/app_ui.dart';

void main() {
  final data = DataFromAsset(rootBundle, 'assets/colors.json');
  final appUI = AppUI(data: data);

  appUI.start();
}
