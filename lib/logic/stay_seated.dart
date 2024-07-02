import 'dart:async';
import 'package:flutter/material.dart';

/* 
 * This class is used to track the time the app was in the foreground.
 * When the user navigates away from the app, the quiet room is closed.
 */

class StaySeated extends StatefulWidget {
  const StaySeated({super.key});

  @override
  StaySeatedState createState() => StaySeatedState();
}

class StaySeatedState extends State<StaySeated> with WidgetsBindingObserver {
  DateTime? _startTime;
  Duration _totalForegroundTime = Duration.zero;
  Timer? _timer;

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
      Navigator.of(context).pop();
    } else if (state == AppLifecycleState.resumed) {
      _startTracking();
      _startTimer();
      debugPrint("timer (re?)started");
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
      setState(() {});
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
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
      currentForegroundTime.inMinutes <= 1
          ? 'you\'ve been here for less than a minute'
          : 'you\'ve been here for ${currentForegroundTime.inMinutes} minutes',
      style: const TextStyle(color: Colors.grey),
    );
  }
}
