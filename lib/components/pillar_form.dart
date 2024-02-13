import 'package:flutter/material.dart';

class PillarForm extends StatelessWidget {
  const PillarForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintStyle: TextStyle(color: Theme.of(context).primaryColor),
        ),
        obscureText: false,
        maxLines: 1,
      ),
    );
  }
}
