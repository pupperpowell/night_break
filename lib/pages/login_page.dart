import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  /* more information on font sizing:
  https://api.flutter.dev/flutter/material/TextTheme-class.html 
  */

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
        // leading: IconButton(
        //   onPressed: () => Navigator.of(context).pop(),
        //   icon: const Icon(Icons.arrow_back),

        middle: Text('login'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text('login'),
            ),
            LoginForm(),
          ],
        ),
      ),
    );
  }
}
