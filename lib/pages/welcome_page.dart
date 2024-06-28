import 'package:flutter/material.dart';
import 'package:night_break/components/title_section.dart';

import '../components/candle.dart';
import '../components/welcome_buttons.dart';

/* 
 * WelcomePage contains a welcome title/subtitle, 
 * and enter-invite-code, login buttons.
 */

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TitleSection(),
            Spacer(),
            WelcomeButtons(),
          ],
        ),
      ),
    );
  }
}
