import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth/auth.dart';
import '../components/navbar.dart';

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
              const Text('Home'),
              CupertinoButton(
                onPressed: () => authService.refresh(context),
                child: const Text('refresh'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
