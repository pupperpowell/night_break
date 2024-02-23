import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:night_break/pages/welcome_page.dart';

class AuthDecider extends StatelessWidget {
  const AuthDecider({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

void checkAuthAndNavigate() async {
  // TODO: check AI generated code below

  // TODO: watch full auth video on YOUTUBE

  /* 
   * https://pub.dev/packages/flutter_secure_storage
   */

  final storage = FlutterSecureStorage();
  final jwt = await storage.read(key: 'auth_jwt');

  if (jwt == null) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const WelcomePage()),
    );
  }
}
