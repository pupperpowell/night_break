import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Sand extends StatelessWidget {
  final double opacity;
  final Size resolution;
  final Color baseColor;
  final Color secondaryColor;

  const Sand({
    super.key,
    this.opacity = 0.5,
    this.resolution = Size.infinite,
    this.baseColor = const Color(0xFFE0C9A6),
    this.secondaryColor = const Color(0xFFD2B48C),
  });

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: ShaderBuilder(
        assetKey: 'assets/shaders/sand.frag',
        (context, shader, child) {
          return ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [baseColor, secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(bounds);
            },
            blendMode: BlendMode.overlay,
            // Overlay the shader over the gradient
            child: CustomPaint(
              painter: SandyPainter(
                shader: shader,
                opacity: opacity,
              ),
              child: Container(),
            ),
          );
        },
      ),
    );
  }
}

class SandyPainter extends CustomPainter {
  final FragmentShader shader;
  final double opacity;

  SandyPainter({
    required this.shader,
    required this.opacity,
  });

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, opacity);
    shader.setFloat(1, size.width);
    shader.setFloat(2, size.height);

    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
