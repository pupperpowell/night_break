import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://nightbreak.app');

Future<void> signUp(String username, String password, String passwordConfirm,
    String name) async {
  final body = <String, dynamic>{
    "username": username,
    "password": password,
    "passwordConfirm": passwordConfirm,
    "name": name
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
    debugPrint(loginAttempt.toString());
  } catch (e) {
    debugPrint(e.toString());
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
