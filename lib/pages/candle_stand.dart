import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'quiet_room.dart';

class CandleStandPage extends StatelessWidget {
  const CandleStandPage({super.key});

// https://docs.flutter.dev/ui/layout

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('welcome to the candle stand'),
            const SizedBox(height: 16.0),
            const Text('I want to be here for '),
            CupertinoButton.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuietRoom()),
                );
              },
              child: const Text('light a candle'),
            ),
          ],
        ),
      ),
    );
  }
}
