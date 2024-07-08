import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/logic/stay_seated.dart';
import 'package:night_break/pages/candle_stand.dart';

import '../components/candle_box.dart';
import '../components/leave_button.dart';

class QuietRoom extends StatelessWidget {
  final int minuteGoal;
  const QuietRoom({super.key, required this.minuteGoal});

  /*
   * on implementing realtime subscriptions
   * https://claude.ai/chat/5b2b06b1-bf42-477e-94b5-2a83bd2bf1b9
   * 
   * on keeping the app open
   * https://claude.ai/chat/00a33c26-5315-42b4-af92-acac27e794c0
  */

  void _navigateBack(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const CandleStandPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32.0),
              StaySeated(
                minuteGoal: minuteGoal,
                onAppPaused: () {
                  // Handle app paused event
                  _navigateBack(context);
                },
              ),
              const Spacer(),
              const CandleBox(),
              const Spacer(),
              LeaveButton(minuteGoal: minuteGoal),
            ],
          ),
        ),
      ),
    );
  }
}
