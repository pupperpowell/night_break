import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import 'generate_invites.dart';

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
