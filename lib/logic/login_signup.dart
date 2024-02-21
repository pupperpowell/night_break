import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://nightbreak.app');

Future<void> signUp(String name, String username, String password,
    String passwordConfirm) async {
  final body = <String, dynamic>{
    "name": name,
    "username": username,
    "password": password,
    "passwordConfirm": passwordConfirm,
  };

  try {
    final signupAttempt = await pb.collection('users').create(body: body);
    debugPrint(signupAttempt.toString());
  } catch (e) {
    debugPrint(e.toString());
  }
}

void login(String username, String password) async {
  try {
    final loginAttempt = await pb.collection('users').authWithPassword(
          username,
          password,
        );

    debugPrint('login successful');
    // debugPrint(loginAttempt.toString());
  } catch (e) {
    debugPrint('failed to authenticate.');
    // debugPrint(e.toString());
  }
}

Future<void> refresh() async {
  if (!pb.authStore.isValid) {
    // TODO: The token has expired. Ask the user to sign in again.
    return;
  }
  final authData = await pb.collection('users').authRefresh();
  debugPrint(authData.toString());
}
