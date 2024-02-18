import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_text_field.dart';
import '../logic/login_signup.dart';

class LoginModal extends StatefulWidget {
  const LoginModal({super.key});

  @override
  State<LoginModal> createState() => _LoginModalState();
}

class _LoginModalState extends State<LoginModal> {
  bool _loginEnabled = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Add listeners to enable/disable button when text changes
    _usernameController.addListener(() {
      _checkLoginStatus();
    });
    _passwordController.addListener(() {
      _checkLoginStatus();
    });
  }

  void _checkLoginStatus() {
    setState(() {
      _loginEnabled = _usernameController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                controller: _usernameController,
                hintText: 'username',
                obscureText: false,
                shimmer: false,
              ),
              const SizedBox(height: 8.0),
              AuthTextField(
                controller: _passwordController,
                hintText: 'password',
                obscureText: true,
                shimmer: false,
              ),
              const SizedBox(height: 8.0),
              CupertinoButton.filled(
                onPressed: () {
                  _loginEnabled
                      ? null
                      : login(
                          _usernameController.text, _passwordController.text);
                },
                /* 
								 * TODO:
								 * Button is incorrectly enabled due to () {} present even if the
								 * evaluated value is null. 
								 * https://api.flutter.dev/flutter/cupertino/CupertinoButton-class.html
								 */
                child: const Text('login'),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
