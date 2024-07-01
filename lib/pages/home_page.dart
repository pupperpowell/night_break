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
                child: Text('Welcome to Night Break v0.3'),
              ),
              const Text("made with love by George Powell"),
              const SizedBox(height: 16.0),
              Candle(created: DateTime.now(), scale: 0.5),
            ],
          ),
        ),
      ),
    );
  }
}
