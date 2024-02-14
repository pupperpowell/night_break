import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: 'username',
            ),
          ),
          TextField(
            decoration: InputDecoration(
              hintText: 'password',
            ),
          ),
        ],
      ),
    );
  }
}
