import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../components/welcome_buttons.dart';

/* 
 * WelcomePage contains a welcome title/subtitle, 
 * and enter-invite-code, login buttons.
 */

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  /* more information on font sizing:
  https://api.flutter.dev/flutter/material/TextTheme-class.html 
  */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Column(
                  // title, logo, and subtitle
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
                        // for light mode: CupertinoIcons.moon_stars_fill
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
                  ],
                ),
                const Spacer(), // this was magic
                const WelcomeButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
