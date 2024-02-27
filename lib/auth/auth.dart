import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';
import '../pages/home_page.dart';
import '../pages/welcome_page.dart';

class AuthService {
  // login
  void login(String username, String password, BuildContext context) async {
    final pb = locator<PocketBase>();

    try {
      final loginAttempt = await pb.collection('users').authWithPassword(
            username,
            password,
          );

      debugPrint('login successful');
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint('failed to authenticate.');
    }
  }

  Future<void> refresh(BuildContext context) async {
    final pb = GetIt.instance<PocketBase>();
    // ensure that the user is logged in
    if (!pb.authStore.isValid) {
      debugPrint('token refresh failed');
      return;
    }

    // refresh token
    await pb.collection('users').authRefresh();
    debugPrint('token refreshed');
  }
}

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PocketBase pb = locator<PocketBase>();

    return Scaffold(
      body: StreamBuilder(
        stream: pb.authStore.onChange,
        builder: (context, snapshot) {
          if (pb.authStore.isValid) {
            return const HomePage();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
