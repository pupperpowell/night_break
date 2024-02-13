import 'package:flutter/material.dart';
import 'package:night_break/components/pillar_form.dart';

class PillarsPage extends StatelessWidget {
  const PillarsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            PillarForm(), 
            PillarForm(), 
            PillarForm(),
          ],
        ),
      ),
    );
  }
}