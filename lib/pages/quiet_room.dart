import 'package:flutter/material.dart';
import 'package:night_break/logic/here_together.dart';
import 'package:night_break/logic/stay_seated.dart';

import '../components/audio_button.dart';
import '../components/candle_box.dart';
import '../components/leave_button.dart';

class QuietRoom extends StatelessWidget {
  final int minuteGoal;
  const QuietRoom({super.key, required this.minuteGoal});

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
                  Navigator.of(context).pop;
                },
              ),
              const HereTogether(),
              const Spacer(),
              const CandleBox(),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  LeaveButton(minuteGoal: minuteGoal),
                  AudioButton(minuteGoal: minuteGoal),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
