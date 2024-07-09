import 'dart:async';

import 'package:flutter/material.dart';
import 'package:night_break/components/flame_shader_widget.dart';

import '../logic/candle_logic.dart';

class Candle extends StatefulWidget {
  final DateTime created;
  final double scale;
  final String owner;
  final bool fadeIn;

  const Candle({
    super.key,
    required this.created,
    required this.scale,
    required this.owner,
    this.fadeIn = false,
  });

  @override
  CandleState createState() => CandleState();
}

class CandleState extends State<Candle> with TickerProviderStateMixin {
  late AnimationController _fadeInController;
  late Animation<double> _fadeInAnimation;

  late AnimationController _fadeOutController;
  late Animation<double> _fadeOutAnimation;
  late Timer _ageCheckTimer;

  @override
  void initState() {
    super.initState();
    _fadeOutController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeOutAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_fadeOutController);

    _fadeInController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _fadeInAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeInController);

    if (widget.fadeIn) {
      _fadeInController.forward();
    } else {
      _fadeInController.value = 1.0;
    }

    _ageCheckTimer =
        Timer.periodic(const Duration(seconds: 2), _checkCandleAge);
  }

  @override
  void dispose() {
    _fadeOutController.dispose();
    _fadeInController.dispose();
    _ageCheckTimer.cancel();
    super.dispose();
  }

  void _checkCandleAge(Timer timer) {
    final now = DateTime.now();
    final candleAge = now.difference(widget.created);
    setState(() {});
    if (candleAge.inHours >= 5) {
      debugPrint('fade out');
      _fadeOutController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final elapsedTime = now.difference(widget.created);
    const sixHours = Duration(hours: 6);
    final progress =
        (elapsedTime.inMilliseconds / sixHours.inMilliseconds).clamp(0.0, 1.0);

    // max height of the candle
    final fullHeight = 185 * widget.scale;

    // height of the candle (as a function of time)
    final currentHeight = fullHeight * (1 - progress * 0.75);
    // ignore: unused_local_variable
    final topOffset = fullHeight - currentHeight;

    return AnimatedBuilder(
        animation: Listenable.merge([_fadeOutAnimation, _fadeInAnimation]),
        builder: (context, child) {
          return Opacity(
            opacity: _fadeOutAnimation.value * _fadeInAnimation.value,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    CustomPaint(
                      size: Size(18 * widget.scale, fullHeight),
                      painter: CandlePainter(
                          created: widget.created, owner: widget.owner),
                    ),
                    Positioned(
                      bottom: currentHeight - (57 * widget.scale),
                      child: SizedBox(
                        width: 100 * widget.scale,
                        height: 38 * widget.scale,
                        child:
                            const RepaintBoundary(child: FlameShaderWidget()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}

class CandlePainter extends CustomPainter {
  final DateTime created;
  final String owner;

  CandlePainter({required this.created, required this.owner});

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
      ..shader = const LinearGradient(
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
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFFF9224),
          Color(0xFFFF9224),
          Color(0xFF58523A),
        ],
        stops: [0.0, 0.2, 1.0],
      ).createShader(Rect.fromLTWH(0, topOffset, size.width, currentHeight));

    // Draw white outline around candle if the logged in user matches the candle.owner
    if (pb.authStore.model.id.toString() == owner) {
      final ovalPaint = Paint()
        ..color = Colors.grey.shade700
        ..style = PaintingStyle.fill
        ..strokeWidth = 4;

      final ovalRect = Rect.fromCenter(
        center: Offset(
            size.width / 2, size.height - 6), // At the bottom of the candle
        width: size.width * 1.5,
        height: size.width * 1.25,
      );

      canvas.drawOval(ovalRect, ovalPaint);
    }
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

    // Draw green box (debug)
    // final greenBoxPaint = Paint()
    //   ..color = Colors.green
    //   ..style = PaintingStyle.fill;
    // canvas.drawRect(const Rect.fromLTWH(0, 0, 5, 5), greenBoxPaint);
  }

  @override
  bool shouldRepaint(covariant CandlePainter oldDelegate) => true;
}
