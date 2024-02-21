import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/components/auth_text_field.dart';
import 'package:night_break/logic/invite_code_logic.dart';
import 'package:night_break/logic/login_signup.dart';

class SignupForm extends StatefulWidget {
  SignupForm({super.key});

  @override
  State<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  bool _signupEnabled = false;

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
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

  void _checkSignupEligibile() {
    // name is entered, username is available, and passwords match
    setState(
      () {
        _signupEnabled = _nameController.text.isNotEmpty &&
            _usernameController.text.isNotEmpty &&
            _passwordController.text.isNotEmpty &&
            checkPasswords();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24.0),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
            child: Text('first and last name',
                style: Theme.of(context).textTheme.labelMedium),
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
                style: Theme.of(context).textTheme.labelMedium),
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
            child: Text('enter a password (at least 6 characters)',
                style: Theme.of(context).textTheme.labelMedium),
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
          CupertinoButton(
            color: Theme.of(context).colorScheme.secondary,
            onPressed: _signupEnabled
                ? () {
                    signUp(
                      _nameController.text,
                      _usernameController.text,
                      _passwordController.text,
                      _passwordConfirmController.text,
                    );
                  }
                : null,
            child: const Text(
              'sign up',
            ),
          ),
          const SizedBox(height: 24.0),
          CupertinoButton(
            onPressed: () {
              useInviteCode("genesis", pb);
            },
            child: const Text('check invite code'),
          )
        ],
      ),
    );
  }
}
