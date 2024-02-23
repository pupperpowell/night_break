import 'package:flutter/material.dart';
import 'package:night_break/pages/profile_page.dart';
import 'package:night_break/pages/signup_page.dart';
import 'package:night_break/theme/dark_theme.dart';

import 'pages/home_page.dart';
import 'pages/welcome_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'night break',
      theme: nightBreakDarkTheme,
      // darkTheme: nightBreakDarkTheme, // ????
      debugShowCheckedModeBanner: false,
      // home: const WelcomePage(),
      home: const WelcomePage(),
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
