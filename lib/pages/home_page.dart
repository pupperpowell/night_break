import 'package:flutter/material.dart';
import 'package:night_break/components/candle.dart';

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
                child: Text('Welcome to Night Break v0.8'),
              ),
              const Text("made with love by George Powell"),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  const SizedBox(width: 16.0),
                  Candle(created: DateTime.now(), scale: 1.0, owner: "uhmm"),
                  const SizedBox(width: 16.0),

                  const SizedBox(width: 16.0),
                  // Candle(
                  //     created: DateTime.now(),
                  //     scale: 1.0,
                  //     owner: "ozbp403k8oppkw4"),
                  const SizedBox(width: 16.0),
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
