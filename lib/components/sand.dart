import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Sand extends StatelessWidget {
  final double graininess;
  final Color baseColor;
  final Color secondaryColor;

  const Sand({
    super.key,
    this.graininess = 100.0,
    this.baseColor = const Color(0xFFE0C9A6),
    this.secondaryColor = const Color(0xFFD2B48C),
  });

  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: 'assets/shaders/sand.frag',
      (context, shader, child) {
        return CustomPaint(
          painter: SandyPainter(
            shader: shader,
            graininess: graininess,
            baseColor: baseColor,
            secondaryColor: secondaryColor,
          ),
          child: Container(),
        );
      },
    );
  }
}

class SandyPainter extends CustomPainter {
  final FragmentShader shader;
  final double graininess;
  final Color baseColor;
  final Color secondaryColor;

  SandyPainter({
    required this.shader,
    required this.graininess,
    required this.baseColor,
    required this.secondaryColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader
      ..setFloat(0, size.width)
      ..setFloat(1, size.height)
      ..setFloat(2, graininess)
      ..setFloat(3, baseColor.red / 255.0)
      ..setFloat(4, baseColor.green / 255.0)
      ..setFloat(5, baseColor.blue / 255.0)
      ..setFloat(6, secondaryColor.red / 255.0)
      ..setFloat(7, secondaryColor.green / 255.0)
      ..setFloat(8, secondaryColor.blue / 255.0);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
