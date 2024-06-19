import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(32.0),
              child: Text('Settings'),
            ),
            const SizedBox(height: 16.0),
            CupertinoButton.filled(
              onPressed: () => authService.logout(),
              child: const Text('logout'),
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
