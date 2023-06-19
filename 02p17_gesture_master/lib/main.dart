import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GestureMasterWidget(),
      ),
    );
  }
}

class GestureMasterWidget extends StatefulWidget {
  const GestureMasterWidget({super.key});

  @override
  State<GestureMasterWidget> createState() => _GestureMasterWidgetState();
}

class _GestureMasterWidgetState extends State<GestureMasterWidget>
    with SingleTickerProviderStateMixin {
  Color color = Colors.amber;
  bool _alignTrigger = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 5000),
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _rotateColor() {
    setState(() {
      final hsl = HSLColor.fromColor(color);
      color = hsl.withHue((hsl.hue + 30) % 360).toColor();
    });
  }

  void _startMovement() {
    setState(() => _alignTrigger = !_alignTrigger);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
          onTap: _rotateColor,
          onLongPress: () => _controller.forward(),
          onLongPressEnd: (details) => _controller.stop(),
          onHorizontalDragEnd: (details) => _startMovement(),
          onVerticalDragEnd: (details) => _startMovement(),
        ),
        RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            alignment: _alignTrigger ? Alignment.centerLeft : Alignment.center,
            child: Container(
              color: color,
              width: 80,
              height: 80,
            ),
          ),
        ),
      ],
    );
  }
}
