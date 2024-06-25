import 'package:flutter/material.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

class Flame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ShaderBuilder(
      assetKey: 'assets/shaders/flame_shader.frag',
      (context, shader, child) {
        return AnimatedSampler(
          (image, size, canvas) {
            shader
              ..setFloat(0, size.width)
              ..setFloat(1, size.height)
              ..setFloat(2, DateTime.now().millisecondsSinceEpoch / 1000)
              ..setFloat(3, 0.1) // bloom
              ..setFloat(4, 0.01) // verticalMotion
              ..setFloat(5, 0.35); // horizontalMotion
            canvas.drawRect(
              Rect.fromLTWH(0, 0, size.width, size.height),
              Paint()..shader = shader,
            );
          },
          child: Container(),
        );
      },
    );
  }
}

class FlameShaderPainter extends CustomPainter {
  final FragmentShader shader;

  FlameShaderPainter(this.shader);

  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    shader.setFloat(2, DateTime.now().millisecondsSinceEpoch / 1000.0);

    final paint = Paint()..shader = shader;
    canvas.drawRect(Offset.zero & size, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
