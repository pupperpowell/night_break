import 'dart:math';

import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase('https://nightbreak.app');

// creates a new row in the 'users' collection.
void signup() async {
  await pb.collection('users').create(
    body: {
      "username": "test_username",
      "password": "12345678",
      "passwordConfirm": "12345678",
      "name": "test",
    },
  );
}

void login() async {
  await pb.collection('users').authWithPassword(
        'YOUR_USERNAME_OR_EMAIL',
        'YOUR_PASSWORD',
      );
}

void uploadInviteCodes() async {
  // TODO: generate four unique invite codes per user

  final body = <String, dynamic>{
    "creator": "RELATION_RECORD_ID",
    "code": "test",
    "used": false
  };

  final record = await pb.collection('invite_codes').create(body: body);
}
