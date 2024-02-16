import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupForm extends StatelessWidget {
  const SignupForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                ),
                Text('back'),
              ],
            ),
          ),
          const SizedBox(height: 12.0),
          const TextField(
            keyboardAppearance: Brightness.dark,
            autofocus: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'invite code',
            ),
          ),
          const TextField(
            keyboardAppearance: Brightness.dark,
            autofocus: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'username',
            ),
          ),
          const SizedBox(height: 8.0),
          const CupertinoTextField(
            placeholder: 'password',
            keyboardAppearance: Brightness.dark,
            obscureText: true,
            // decoration: BoxDecoration(),
          ),
        ],
      ),
    );
  }
}
