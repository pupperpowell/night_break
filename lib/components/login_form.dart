import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../logic/login_signup.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CupertinoTextField(
            placeholder: 'username',
            keyboardAppearance: Brightness.dark,
            autofocus: true,
            // TODO: watch login/signup video again
          ),
          SizedBox(height: 8.0),
          CupertinoTextField(
            placeholder: 'password',
            keyboardAppearance: Brightness.dark,
            obscureText: true,
          ),
        ],
      ),
    );
  }
}
