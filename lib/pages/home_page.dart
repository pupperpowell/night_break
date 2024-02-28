import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/logic/invite_code_logic.dart';
import 'package:pocketbase/pocketbase.dart';

import '../auth/auth.dart';
import '../components/navbar.dart';
import '../locator.dart';

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
              CupertinoButton.filled(
                onPressed: () => authService.refresh(context),
                child: const Text('refresh'),
              ),
              const SizedBox(height: 16.0),
              CupertinoButton.filled(
                onPressed: () => authService.logout(),
                child: const Text('logout'),
              ),
              const SizedBox(height: 16.0),
              CupertinoButton.filled(
                onPressed: () => allocateInviteCodes(
                    '1huwgre6010ec0s', locator<PocketBase>()),
                child: const Text('test invite code'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
