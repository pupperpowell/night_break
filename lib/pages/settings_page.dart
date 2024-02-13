import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Text('Settings'),
      floatingActionButton: FloatingActionButton(
        onPressed: AdaptiveTheme.of(context).toggleThemeMode,
        child: const Text('hehe press meee!'),
      )
    );
  }
}
