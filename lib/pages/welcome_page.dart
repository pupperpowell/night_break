import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:night_break/components/login_form.dart';

// import '../components/navbar.dart';
import '../theme/dark_theme.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  /* more information on font sizing:
  https://api.flutter.dev/flutter/material/TextTheme-class.html 
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'night break',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 22.0),
                child: Icon(
                  CupertinoIcons.moon_stars,
                  size: 64.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 64.0),
                child: Text(
                  'an app for the mbc staff community',
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32.0),

              // enter invite code

              // login
            ],
          ),
        ),
      ),
    );
  }
}
