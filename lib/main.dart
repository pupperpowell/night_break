import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:night_break/auth/auth.dart';
import 'package:night_break/locator.dart';
import 'package:night_break/logic/candle_logic.dart';
import 'package:night_break/theme/dark_theme.dart';

import 'pages/candle_stand.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

Future<void> main() async {
  await setup();
  await CandleLogic.fetchCandles();

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

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        onDestinationSelected: (int index) {
          setState(
            () {
              _currentPageIndex = index;
            },
          );
        },
        selectedIndex: _currentPageIndex,
        destinations: const [
          NavigationDestination(
            icon: Icon(Symbols.favorite),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Symbols.candle_rounded),
            label: 'Candle Stand',
          ),
          NavigationDestination(
            icon: Icon(Symbols.settings),
            label: 'Settings',
          ),
        ],
        backgroundColor: Colors.black,
        height: 50, // 50 for iOS, 70 for android?
      ),
      body: <Widget>[
        const HomePage(),
        const CandleStandPage(),
        const SettingsPage(),
      ].elementAt(_currentPageIndex),
    );
  }
}
