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
  static const squareSize = 80.0;
  Color color = Colors.amber;
  late final _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  );
  double x = 0;
  double y = 0;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          left: x,
          right: -x,
          top: y,
          bottom: -y,
          child: Center(
            child: RotationTransition(
              turns: Tween(begin: 0.0, end: 1.0).animate(_controller),
              child: Container(
                color: color,
                width: squareSize,
                height: squareSize,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: GestureDetector(
            onTap: _rotateColor,
            onLongPress: () => _controller.repeat(),
            onLongPressEnd: (details) => _controller.stop(),
            onPanUpdate: (details) => setState(() {
              x += details.delta.dx;
              y += details.delta.dy;
            }),
          ),
        ),
      ],
    );
  }
}
