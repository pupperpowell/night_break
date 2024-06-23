import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/components/candle.dart';

class QuietRoom extends StatelessWidget {
  const QuietRoom({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Quiet Room'),
            const Candle(),
            CupertinoButton.filled(
              onPressed: () {
                Navigator.pop(context);
              },
              // ignore: prefer_const_constructors
              child: Text('leave early'),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
