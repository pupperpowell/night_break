import 'package:flutter/material.dart';
import 'package:night_break/theme/dark_theme.dart';

import 'pages/welcome_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'night break',
      theme: darkTheme,
      home: const SafeArea(child: WelcomePage()),
      routes: {
        '/settings': (context) => const SettingsPage(),
        '/welcome': (context) => const WelcomePage(),
      },
    );
  }
}
