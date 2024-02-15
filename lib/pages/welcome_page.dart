import 'package:flutter/material.dart';
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: Text(
                'night break',
                style: Theme.of(context).textTheme.displayLarge,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'an app for the mbc staff community',
              style: Theme.of(context).textTheme.labelLarge,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.0),

            // login button

            // register button

            const LoginForm(),
          ],
        ),
      ),
    );
  }
}
