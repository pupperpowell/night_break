import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';

import 'package:night_break/auth/auth.dart';
import 'package:night_break/locator.dart';
import 'package:night_break/theme/dark_theme.dart';

Future<void> main() async {
  await setup();
  runApp(
    const MainApp(),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'night break',
      theme: nightBreakDarkTheme,
      darkTheme: nightBreakDarkTheme,
      debugShowCheckedModeBanner: false,
      home: const AuthPage(),
    );
  }
}
