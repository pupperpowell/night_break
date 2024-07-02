import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/logic/stay_seated.dart';

import '../components/candle_box.dart';

class QuietRoom extends StatelessWidget {
  const QuietRoom({super.key});

  /*
   * on implementing realtime subscriptions
   * https://claude.ai/chat/5b2b06b1-bf42-477e-94b5-2a83bd2bf1b9
   * 
   * on keeping the app open
   * https://claude.ai/chat/00a33c26-5315-42b4-af92-acac27e794c0
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Quiet Room'),
              const SizedBox(height: 16.0),
              const StaySeated(),
              const Spacer(),
              const CandleBox(),
              const Spacer(),
              CupertinoButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'leave early',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
