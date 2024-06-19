import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:night_break/main.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';
import '../pages/welcome_page.dart';

class AuthService {
  // sign up
  Future<String> signUp(
    String name,
    String username,
    String email,
    String password,
    String passwordConfirm,
    String pillar,
    BuildContext context,
  ) async {
    final pb = locator<PocketBase>();

    final body = <String, dynamic>{
      "name": name,
      "username": username,
      "password": password,
      "email": email,
      "passwordConfirm": passwordConfirm,
      "pillar": pillar
    };
    // check if invite code is valid
    try {
      // try to create user with provided parameters
      final signupAttempt = await pb.collection('users').create(body: body);

      // and sign the user in
      login(
        username,
        password,
        context,
      );
      return "signed up and signed in with id ${signupAttempt.id}";
    } catch (e) {
      debugPrint('failed to create user (auth.dart)');
      return e.toString();
    }
  }

  // login
  void login(String username, String password, BuildContext context) async {
    final pb = locator<PocketBase>();

    try {
      await pb.collection('users').authWithPassword(
            username,
            password,
          );

      debugPrint('login successful');
      Navigator.pop(context);
    } catch (e) {
      debugPrint('failed to authenticate.');
    }
  }

  void logout() {
    final pb = GetIt.instance<PocketBase>();
    pb.authStore.clear();
    debugPrint('logged out');
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
            debugPrint('valid token detected- user is logged in.');
            return const Home();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
