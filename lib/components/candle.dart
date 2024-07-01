import 'package:flutter/material.dart';

import 'package:night_break/components/flame_shader_widget.dart';

class Candle extends StatefulWidget {
  final DateTime created;
  final double scale;

  const Candle({super.key, required this.created, required this.scale});

  @override
  CandleState createState() => CandleState();
}

class CandleState extends State<Candle> {
  /*
   * TODO:
   * 1. make candle shorter and shorter over time
   *    (full height at 0 minutes, 0 height at 6 hours)
   * 2. change candle+flame size by this.scale
   * 
   */

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: <Widget>[
            CustomPaint(
              size: const Size(18, 150),
              painter: CandlePainter(),
            ),
            const Positioned(
              top: 20,
              child: SizedBox(
                width: 100, // should always be aspect ratio 8:3
                height: 38,
                child: RepaintBoundary(child: FlameShaderWidget()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CandlePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final wickPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          // Colors.black,
          // Colors.black,
          // Color(0xFFE8C1A0),
          // Color(0xFFE8C1A0),
          Color(0xFFE8C1A0),
          Color(0xFFE8C1A0),
          Colors.black,
          Colors.black,
        ],
        stops: [0.0, 0.4, 0.75, 1.0],
      ).createShader(Rect.fromLTWH(size.width / 2 - 2, 40, 4, 22));

    final waxPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF9224),
          Color(0xFFFF9224),
          Color(0xFF58523A),
        ],
        stops: [0.0, 0.2, 1.0],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    // Draw wax
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(
            0, 50, size.width, size.height), // last element is height.?
        const Radius.circular(15),
      ),
      waxPaint,
    );

    // Draw wick
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width / 2 - 2, 40, 4, 22),
          const Radius.circular(25),
        ),
        wickPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
