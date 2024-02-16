import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:night_break/components/title_screen.dart';

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
      body: const SafeArea(
        child: Column(
          children: [
            TitleScreen(),
            Spacer(), // this was magic
            WelcomeButtons(),
          ],
        ),
      ),
    );
  }
}
