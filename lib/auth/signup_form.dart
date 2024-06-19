import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/components/auth_text_field.dart';
import 'package:night_break/logic/invite_code_logic.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';
import 'auth.dart';

class SignupForm extends StatefulWidget {
  const SignupForm({super.key, required this.inviteCode});

  final String inviteCode;

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _signupEnabled = false;

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Add listeners to enable/disable button when text changes
    _nameController.addListener(() {
      _checkSignupEligibile();
    });

    _usernameController.addListener(() {
      _checkSignupEligibile();
    });

    _emailController.addListener(() {
      _checkSignupEligibile();
    });

    _passwordController.addListener(() {
      _checkSignupEligibile();
    });

    _passwordConfirmController.addListener(() {
      _checkSignupEligibile();
    });
  }

  bool checkPasswords() {
    if (_passwordController.text.length <= 5) {
      return false;
    } else if (_passwordController.text == _passwordConfirmController.text) {
      return true;
    }
    return false;
  }

  bool checkEmail() {
    final regex = RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
    if (regex.hasMatch(_emailController.text)) {
      return true;
    }
    return false;
  }

  void _checkSignupEligibile() {
    // name is entered, username is available, and passwords match
    setState(
      () {
        _signupEnabled = _nameController.text.isNotEmpty &&
            _usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            checkPasswords() &&
            checkEmail();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final pb = locator<PocketBase>();
    final authService = AuthService();

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 12.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Text('what\'s your name?',
                style: Theme.of(context).textTheme.labelLarge),
          ),
          AuthTextField(
            controller: _nameController,
            hintText: 'name',
            obscureText: false,
            shimmer: false,
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Text('enter a username',
                style: Theme.of(context).textTheme.labelLarge),
          ),
          AuthTextField(
            controller: _usernameController,
            hintText: 'username',
            obscureText: false,
            shimmer: false,
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Text(
                'enter your email address\n(will only be used for password resets)',
                style: Theme.of(context).textTheme.labelLarge),
          ),
          AuthTextField(
            controller: _emailController,
            hintText: 'email',
            obscureText: false,
            shimmer: false,
          ),
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Text('enter a password (at least 6 characters)',
                style: Theme.of(context).textTheme.labelLarge),
          ),
          AuthTextField(
            controller: _passwordController,
            hintText: 'password',
            obscureText: true,
            shimmer: false,
          ),
          const SizedBox(height: 8.0),
          AuthTextField(
            controller: _passwordConfirmController,
            hintText: 'confirm password',
            obscureText: true,
            shimmer: false,
          ),
          const SizedBox(height: 48.0),

          // if there are any problems with signing up, show cupertino dialogue

          CupertinoButton(
            color: Theme.of(context).colorScheme.secondary,
            onPressed: _signupEnabled
                ? () {
                    // sign up
                    try {
                      Future<String> signup = authService.signUp(
                        _nameController.text,
                        _usernameController.text,
                        _emailController.text,
                        _passwordController.text,
                        _passwordConfirmController.text,
                        widget.inviteCode,
                        context,
                      );
                      debugPrint('result of signup: ${signup.toString()}');
                    } catch (e) {
                      debugPrint('SIGNUP FAILED');
                      showCupertinoDialog(
                        context: context,
                        builder: (context) => CupertinoAlertDialog(
                          title: const Text('sign up failed'),
                          content: Text(e.toString()),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text('ok'),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }
                : null,
            child: const Text(
              'sign up',
            ),
          ),
          const SizedBox(height: 24.0),
        ],
      ),
    );
  }
}
