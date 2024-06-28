import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class QuietRoom extends StatelessWidget {
  const QuietRoom({super.key});

  /*
   * https://claude.ai/chat/5b2b06b1-bf42-477e-94b5-2a83bd2bf1b9
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Quiet Room'),
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
