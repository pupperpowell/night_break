import 'package:flutter/material.dart';
import 'package:night_break/components/candle.dart';
import 'package:night_break/components/flame_shader_widget.dart';

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
              // SizedBox(
              //   width: 240, // or any size you want
              //   height: 100, // or any size you want
              //   child: RepaintBoundary(child: FlameShaderWidget()),
              // ),
              SizedBox(height: 32.0),
              Candle(),
            ],
          ),
        ),
      ),
    );
  }
}
