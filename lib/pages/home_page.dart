import 'package:flutter/material.dart';

import '../components/candle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 16.0),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Welcome to Night Break v0.2'),
              ),
              Text("made with love by George Powell"),
              SizedBox(height: 32.0),
              Candle(),
            ],
          ),
        ),
      ),
    );
  }
}
