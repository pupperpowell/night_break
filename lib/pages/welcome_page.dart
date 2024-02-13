import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:night_break/components/navbar.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Welcome'),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}