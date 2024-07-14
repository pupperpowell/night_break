import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:night_break/components/seven_candles.dart';

import '../logic/candle_logic.dart';

import '../auth/auth.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = AuthService();

    final userModel = jsonDecode(pb.authStore.model.toString());
    final String name = userModel['name'];

    final DateTime joined = DateTime.parse(userModel['created']);
    final String joinedString = DateFormat('dd MMMM yyyy').format(joined);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('hi $name', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 8.0),
              Text('joined on ${joinedString.toLowerCase()}'),
              const SizedBox(height: 32.0),
              const SevenCandles(),
              const Spacer(),
              CupertinoButton(
                onPressed: () => authService.logout(),
                child: const Text('logout'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
