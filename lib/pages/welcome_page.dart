import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: Text(
                    'night break',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
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
                CupertinoButton.filled(
                  onPressed: () {},
                  child: const Text('enter invite code'),
                ),
                // login
                const SizedBox(height: 16.0),
                CupertinoButton(
                  onPressed: () {},
                  color: Theme.of(context).colorScheme.secondary,
                  child: const Text('login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
