import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

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
          SizedBox(height: 12.0),
          TextField(
            keyboardAppearance: Brightness.dark,
            autofocus: true,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: 'username',
            ),
          ),
          SizedBox(height: 8.0),
          CupertinoTextField(
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
