import '../model/color_sample.dart';

abstract interface class IData {
  Future<List<ColorSample>> getColorSamples();
}
