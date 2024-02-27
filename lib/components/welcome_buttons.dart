import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/about_page.dart';
import 'invite_code_modal.dart';
import '../auth/login_modal.dart';

class WelcomeButtons extends StatelessWidget {
  const WelcomeButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoButton.filled(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (context) => InviteCodeModal(),
              );
            },
            child: const Text('enter invite code'),
          ),
          const SizedBox(height: 16.0),

          CupertinoButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (context) => LoginModal(),
              );
            },
            color: Theme.of(context).colorScheme.secondary,
            child: const Text('login'),
          ),
          const SizedBox(height: 8.0),

          // about button
          CupertinoButton(
            onPressed: () {
              showModalBottomSheet<void>(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                // backgroundColor: Colors.black,
                builder: (context) => const AboutPage(),
              );
            },
            child: const Text('about this app'),
          ),
        ],
      ),
    );
  }
}
