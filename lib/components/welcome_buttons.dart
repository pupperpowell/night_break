import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CupertinoButton.filled(
          onPressed: () {},
          child: const Text('enter invite code'),
        ),
        const SizedBox(height: 16.0),
        CupertinoButton(
          onPressed: () => Navigator.of(context).pushNamed('/login'),
          color: Theme.of(context).colorScheme.secondary,
          child: const Text('login'),
        ),
        const SizedBox(height: 8.0),
        CupertinoButton(
          onPressed: () {
            Navigator.of(context).pushNamed('/about');
          },
          child: const Text('about this app'),
          // TODO: Fix this, it doesn't work at all.
        ),
      ],
    );
  }
}
