import 'package:flutter/material.dart';

// import '../components/navbar.dart';
import '../theme/dark_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const Center(
        child: Column(
          children: [
            Text('night break'),
            SizedBox(height: 8.0),
            Text('an app for the mbc staff community'),
          ],
        ),
      ),
    );
  }
}
