import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';

import 'pages/pillars_page.dart';
import 'pages/welcome_page.dart';
import 'pages/settings_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.dark,
      builder: (theme, darkTheme) => MaterialApp(
          title: 'night break',
          theme: theme,
          darkTheme: darkTheme,
          home: const SafeArea(child: WelcomePage()),
          routes: {
            '/pillars': (context) => const PillarsPage(),
            '/settings': (context) => const SettingsPage(),
            '/welcome': (context) => const WelcomePage(),
          }
      ),
    );
  }
}
