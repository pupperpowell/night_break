import 'dart:async';

import 'package:flutter/cupertino.dart';

class LeaveButton extends StatefulWidget {
  final int minuteGoal;
  const LeaveButton({super.key, required this.minuteGoal});

  @override
  LeaveButtonState createState() => LeaveButtonState();
}

class LeaveButtonState extends State<LeaveButton> with WidgetsBindingObserver {
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
    _startTime = DateTime.now().toUtc();
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
    return CupertinoButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        currentForegroundTime.inMinutes >= widget.minuteGoal
            ? 'leave'
            : 'leave early',
      ),
    );
  }
}
