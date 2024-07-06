import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/components/candle.dart';
import 'package:pocketbase/pocketbase.dart';

import '../logic/candle_logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Welcome to Night Break v0.5'),
              ),
              const Text("made with love by George Powell"),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  Candle(created: DateTime.now(), scale: 1.0),
                  const SizedBox(width: 8.0),
                  Candle(
                      created:
                          DateTime.now().subtract(const Duration(minutes: 30)),
                      scale: 1.0),
                  const SizedBox(width: 8.0),
                  Candle(
                    created: DateTime.now().subtract(const Duration(hours: 1)),
                    scale: 1.0,
                  ),
                  const SizedBox(width: 8.0),
                  Candle(
                    created: DateTime.now().subtract(const Duration(hours: 2)),
                    scale: 1.0,
                  ),
                  const SizedBox(width: 8.0),
                  Candle(
                    created: DateTime.now().subtract(const Duration(hours: 3)),
                    scale: 1.0,
                  ),
                  const SizedBox(width: 8.0),
                  Candle(
                    created: DateTime.now().subtract(const Duration(hours: 4)),
                    scale: 1.0,
                  ),
                  const SizedBox(width: 8.0),
                  Candle(
                    created:
                        DateTime.now().subtract(const Duration(seconds: 17997)),
                    scale: 1.0,
                  ),
                  const SizedBox(width: 8.0),
                ],
              ),
              const SizedBox(width: 64.0),
              // CupertinoButton(
              //   onPressed: () async {
              //     List<RecordModel> candles = await CandleLogic.fetchCandles();
              //     debugPrint('candle list: $candles');
              //   },
              //   child: const Text('see global candles'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
