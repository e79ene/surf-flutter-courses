import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../model/color_sample.dart';

class ColorDetailsScreen extends StatelessWidget {
  const ColorDetailsScreen({
    super.key,
    required this.colorSample,
  });

  final ColorSample colorSample;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Stack(
              children: [
                Positioned.fill(
                  child: ColoredBox(color: colorSample.color),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 16),
                  child: Text(
                    colorSample.name,
                    style: const TextStyle(
                      color: Color(0xFF252838),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _CopyButton(title: "Hex", value: colorSample.hex),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                        child: _CopyButton(
                      title: "Red",
                      value: "${colorSample.color.red}",
                    )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _CopyButton(
                      title: "Green",
                      value: "${colorSample.color.green}",
                    )),
                    const SizedBox(width: 16),
                    Expanded(
                        child: _CopyButton(
                      title: "Blue",
                      value: "${colorSample.color.blue}",
                    )),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CopyButton extends StatelessWidget {
  final String title;
  final String value;

  const _CopyButton({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _copyValue,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }

  void _copyValue() async {
    await Clipboard.setData(ClipboardData(text: value));
  }
}
