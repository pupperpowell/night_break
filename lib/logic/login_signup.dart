import 'package:flutter/cupertino.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://nightbreak.app');

Future<void> signUp() async {
  final body = <String, dynamic>{
    "username": "Bob",
    "email": "bob@example.com",
    "password": "12345678",
    "passwordConfirm": "12345678",
    "name": "Bob Smith"
  };

  final record = await pb.collection('users').create(body: body);
  debugPrint(record.toString());
}

void login() async {
  try {
    await pb.collection('users').authWithPassword(
          'username',
          'password',
        );
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
