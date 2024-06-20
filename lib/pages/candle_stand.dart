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
                // show the dialog for quiet room
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('thank you for being here'),
                    content: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Text(
                              'turning off your screen or going to a different app will put out your candle'),
                          SizedBox(height: 6.0),
                          Text(
                              'a bell will ring when your time is up, and every minute after that.'),
                          SizedBox(height: 6.0),
                          Text("enjoy."),
                        ],
                      ),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('okay'),
                      ),
                    ],
                  ),
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
