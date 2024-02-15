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

// void logout() async {
//   await pb.logout();
// }

// // end codeium segment

// final authData = await pb.collection('users').authWithPassword(
//   'YOUR_USERNAME_OR_EMAIL',
//   'YOUR_PASSWORD',
// );

// // after the above you can also access the auth data from the authStore
// print(pb.authStore.isValid);
// print(pb.authStore.token);
// print(pb.authStore.model.id);

// // "logout" the last authenticated account
// pb.authStore.clear();