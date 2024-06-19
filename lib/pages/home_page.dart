import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../auth/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 16.0),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Welcome to Night Break v0.1'),
              ),
              const Text("made with love by George Powell"),
              // const SizedBox(height: 16.0),
              // CupertinoButton.filled(
              //   onPressed: () => authService.refresh(context),
              //   child: const Text('refresh'),
              // ),
              const SizedBox(height: 16.0),
              CupertinoButton.filled(
                onPressed: () => authService.logout(),
                child: const Text('logout'),
              ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}
