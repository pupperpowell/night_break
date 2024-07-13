import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:night_break/components/seven_candles.dart';

import '../logic/candle_logic.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<int> getWeeklyCandles() async {
    int weeklyCandles = 0;

    return weeklyCandles;
  }

  @override
  Widget build(BuildContext context) {
    final userModel = jsonDecode(pb.authStore.model.toString());
    final String name = userModel['name'];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Text('hi $name', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 32.0),
              const SevenCandles(weeklyCandleCount: ,),
            ],
          ),
        ),
      ),
    );
  }
}
