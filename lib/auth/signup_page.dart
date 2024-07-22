import 'package:flutter/material.dart';
import 'signup_form.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key, required this.inviteCode});

  final String inviteCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        title: const Text('sign up'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Center(
              child: Column(
                children: [
                  SignupForm(inviteCode: inviteCode),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
