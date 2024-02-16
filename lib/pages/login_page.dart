import 'package:flutter/material.dart';

import '../components/login_form.dart';
import '../components/title_screen.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: const SafeArea(
        child: Column(
          children: [
            TitleScreen(),
            Spacer(),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
