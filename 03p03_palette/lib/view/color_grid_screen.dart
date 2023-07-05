import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_details_screen.dart';
import '../data/i_data.dart';
import '../model/color_sample.dart';

class ColorGridScreen extends StatelessWidget {
  const ColorGridScreen({
    super.key,
    required this.data,
  });

  final IData data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          title: const Text("Эксклюзивная палитра\n«Colored Box»"),
        ),
      ),
      body: FutureBuilder(
        future: data.getColorSamples(),
        builder: (context, snapshot) {
          final colorsSamples = snapshot.data;
          return colorsSamples != null
              ? _ColorGrid(colorsSamples: colorsSamples)
              : const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class _ColorGrid extends StatelessWidget {
  final List<ColorSample> colorsSamples;

  const _ColorGrid({
    required this.colorsSamples,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      childAspectRatio: 100 / 135,
      mainAxisSpacing: 40,
      crossAxisSpacing: 22,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      children: [
        for (final colorsSample in colorsSamples)
          _ColorTile(colorSample: colorsSample),
      ],
    );
  }
}

class _ColorTile extends StatelessWidget {
  const _ColorTile({
    required this.colorSample,
  });

  final ColorSample colorSample;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _openDetails(context),
      onLongPress: _copyHex,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: ColoredBox(color: colorSample.color),
            ),
          ),
          Text(
            "${colorSample.name}\n${colorSample.hex}",
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  void _copyHex() async {
    await Clipboard.setData(ClipboardData(text: colorSample.hex));
  }

  void _openDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorDetailsScreen(colorSample: colorSample),
      ),
    );
  }
}
