import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/components/auth_text_field.dart';

class LoginModal extends StatelessWidget {
  LoginModal({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          AuthTextField(
            controller: usernameController,
            hintText: 'username',
            obscureText: false,
            shimmer: false,
          ),
          const SizedBox(height: 8.0),
          AuthTextField(
            controller: passwordController,
            hintText: 'password',
            obscureText: true,
            shimmer: false,
          )
        ],
      ),
    );
  }
}
