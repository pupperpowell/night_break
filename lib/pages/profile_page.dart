import 'package:flutter/material.dart';

import '../components/navbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Profile'),
      ),
      bottomNavigationBar: NavBar(),
    );
  }
}