import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'candle_logic.dart';

/* 
 * This class is used to track the time the app was in the foreground.
 * When the user navigates away from the app, the quiet room is closed.
 */

class StaySeated extends StatefulWidget {
  final int minuteGoal;
  final VoidCallback onAppPaused;

  const StaySeated(
      {super.key, required this.minuteGoal, required this.onAppPaused});

  @override
  StaySeatedState createState() => StaySeatedState();
}

class StaySeatedState extends State<StaySeated> with WidgetsBindingObserver {
  DateTime? _startTime;
  Duration _totalForegroundTime = Duration.zero;
  Timer? _timer;

  bool _candleLit = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startTracking();
    _startTimer();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stopTimer();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _stopTracking();
      _stopTimer();
      debugPrint("timer stopped");
      widget.onAppPaused();
    } else if (state == AppLifecycleState.resumed) {
      debugPrint("StaySeated resumed.");
    }
  }

  void _startTracking() {
    _startTime = DateTime.now();
  }

  void _stopTracking() {
    if (_startTime != null) {
      _totalForegroundTime += DateTime.now().difference(_startTime!);
      _startTime = null;
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (currentForegroundTime.inMinutes >= widget.minuteGoal &&
            !_candleLit) {
          _lightCandle();
        }
        // TODO: play bell at minuteGoal
        // TODO: play censer bells at start, and every minute after goal
      });
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _lightCandle() {
    if (!_candleLit) {
      CandleLogic.createCandle(
        pb.authStore.model.id.toString(),
      );
      _candleLit = true;
    }
  }

  Duration get currentForegroundTime {
    return _totalForegroundTime +
        (_startTime != null
            ? DateTime.now().difference(_startTime!)
            : Duration.zero);
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentForegroundTime.inSeconds < 60
          ? 'you\'ve been here for less than a minute'
          : currentForegroundTime.inSeconds < 120
              ? 'you\'ve been here for a minute'
              : 'you\'ve been here for ${currentForegroundTime.inMinutes} minutes',
      style: const TextStyle(color: Colors.grey),
    );
  }
}
