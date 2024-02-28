import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:night_break/logic/invite_code_logic.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';
import '../pages/home_page.dart';
import '../pages/welcome_page.dart';

class AuthService {
  // sign up
  Future<void> signUp(
    String name,
    String username,
    String password,
    String passwordConfirm,
    String inviteCode,
    BuildContext context,
  ) async {
    final pb = locator<PocketBase>();

    final body = <String, dynamic>{
      "name": name,
      "username": username,
      "password": password,
      "passwordConfirm": passwordConfirm,
      "invited_by": await getInvitedById(inviteCode, pb),
    };
    // check if invite code is valid
    if (await verifyInviteCode(inviteCode, pb)) {
      try {
        // try to create user with provided parameters
        final signupAttempt = await pb.collection('users').create(body: body);

        // if successful, use the invite code
        useInviteCode(inviteCode, pb);
        // and sign the user in
        login(
          username,
          password,
          context,
        );

// debug to check if correct user id
        debugPrint(signupAttempt.id);

        // allocate invite codes
        allocateInviteCodes(signupAttempt.id.toString(), pb);
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('invalid invite code');
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
            return const HomePage();
          } else {
            return const WelcomePage();
          }
        },
      ),
    );
  }
}
