import 'package:flutter/material.dart';

// import '../components/navbar.dart';
import '../theme/dark_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Column(
        children: [
          Text('welcome to night break'),
        ],
      ),
    );
  }
}
