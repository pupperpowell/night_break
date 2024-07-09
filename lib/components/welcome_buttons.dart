import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'about_modal.dart';
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
          // // debug login

          // CupertinoButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => const Home()),
          //     );
          //   },
          //   child: const Text('debug login'),
          // ),
          // const SizedBox(height: 16.0),

          // invite code

          CupertinoButton.filled(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (context) => const InviteCodeModal(),
              );
            },
            child: const Text('enter invite code'),
          ),
          const SizedBox(height: 16.0),

          // login
          CupertinoButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                showDragHandle: true,
                isScrollControlled: true,
                builder: (context) => const LoginModal(),
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
                backgroundColor: Colors.black.withOpacity(0.9),
                builder: (context) => const AboutModal(),
              );
            },
            child: const Text('about this app'),
          ),
        ],
      ),
    );
  }
}
