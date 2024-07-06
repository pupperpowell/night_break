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
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final elapsedTime = now.difference(widget.created);
    final sixHours = Duration(hours: 6);
    final progress =
        (elapsedTime.inMilliseconds / sixHours.inMilliseconds).clamp(0.0, 1.0);

    final fullHeight = 175 * widget.scale;
    final currentHeight = fullHeight * (1 - progress * 0.75);
    final topOffset = fullHeight - currentHeight;

    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
          clipBehavior: Clip.none,
          children: <Widget>[
            CustomPaint(
              size: Size(18 * widget.scale, fullHeight),
              painter: CandlePainter(created: widget.created),
            ),
            Positioned(
              bottom: currentHeight - (56 * widget.scale),
              child: SizedBox(
                width: 100 * widget.scale,
                height: 38 * widget.scale,
                child: const RepaintBoundary(child: FlameShaderWidget()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CandlePainter extends CustomPainter {
  final DateTime created;

  CandlePainter({required this.created});

  @override
  void paint(Canvas canvas, Size size) {
    final now = DateTime.now();
    final elapsedTime = now.difference(created);
    const sixHours = Duration(hours: 6);
    final progress =
        (elapsedTime.inMilliseconds / sixHours.inMilliseconds).clamp(0.0, 1.0);

    final fullHeight = size.height - 50; // Full height of the wax
    final currentHeight = fullHeight * (1 - progress);
    final topOffset = size.height - currentHeight;

    final wickPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFE8C1A0),
          Color(0xFFE8C1A0),
          Colors.black,
          Colors.black,
        ],
        stops: [0.0, 0.4, 0.75, 1.0],
      ).createShader(Rect.fromLTWH(size.width / 2 - 2, topOffset - 10, 4, 22));

    final waxPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF9224),
          Color(0xFFFF9224),
          Color(0xFF58523A),
        ],
        stops: [0.0, 0.2, 1.0],
      ).createShader(Rect.fromLTWH(0, topOffset, size.width, currentHeight));

    // Draw wax
    canvas.drawRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, topOffset, size.width, currentHeight),
        const Radius.circular(15),
      ),
      waxPaint,
    );

    // Draw wick
    canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(size.width / 2 - 2, topOffset - 10, 4, 22),
          const Radius.circular(25),
        ),
        wickPaint);

    // Draw green box
    final greenBoxPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Rect.fromLTWH(0, 0, 5, 5), greenBoxPaint);
  }

  @override
  bool shouldRepaint(covariant CandlePainter oldDelegate) => true;
}
