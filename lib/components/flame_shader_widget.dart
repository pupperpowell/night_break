import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class FlameShaderWidget extends StatefulWidget {
  const FlameShaderWidget({super.key});

  @override
  FlameShaderWidgetState createState() => FlameShaderWidgetState();
}

class FlameShaderWidgetState extends State<FlameShaderWidget>
    with SingleTickerProviderStateMixin {
  late Ticker _ticker;
  double _time = 0.0;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        _time = elapsed.inMilliseconds / 1000.0; // Convert to seconds
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: 'assets/shaders/flame_shader.frag',
      (context, shader, child) {
        return CustomPaint(
          painter: FlameShaderPainter(shader, _time),
          size: Size.infinite,
        );
      },
    );
  }
}

class FlameShaderPainter extends CustomPainter {
  final FragmentShader shader;
  final double time;

  FlameShaderPainter(this.shader, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, time);

    canvas.drawRect(
      Offset.zero & size,
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant FlameShaderPainter oldDelegate) =>
      oldDelegate.time != time;
}
