import 'dart:math';

import 'package:flutter/material.dart';

import 'dart:math' as math;

class Candle extends StatefulWidget {
  final double width;
  final double height;

  const Candle({super.key, this.width = 50, this.height = 100});

  @override
  _CandleState createState() => _CandleState();
}

class _CandleState extends State<Candle> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    )..repeat(reverse: false);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: Size(widget.width, widget.height),
          painter: CandlePainter(_controller.value),
        );
      },
    );
  }
}

class CandlePainter extends CustomPainter {
  final double animationValue;
  final Random random = Random();

  CandlePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final candlePaint = Paint()..color = Colors.white;
    final flamePaint = Paint()..color = Colors.orange;

    // Draw candle body
    canvas.drawRect(
      Rect.fromLTWH(size.width * 0.3, size.height * 0.3, size.width * 0.4,
          size.height * 0.7),
      candlePaint,
    );

    // Draw flickering flame
    final flamePath = Path();
    flamePath.moveTo(size.width * 0.5, size.height * 0.3);

    for (var i = 0; i < 5; i++) {
      final x = size.width * 0.5 +
          math.sin(animationValue * math.pi * 2 + i) * size.width * 0.1;
      final y = size.height * (0.3 - i * 0.05) -
          random.nextDouble() * size.height * 0.05 * animationValue;
      flamePath.lineTo(x, y);
    }

    flamePath.lineTo(size.width * 0.5, size.height * 0.3);
    canvas.drawPath(flamePath, flamePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
