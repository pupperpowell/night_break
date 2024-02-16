import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:night_break/components/auth_text_field.dart';

class InviteCodeModal extends StatelessWidget {
  InviteCodeModal({super.key});

  final inviteCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AuthTextField(
            controller: inviteCodeController,
            hintText: 'code',
            obscureText: false,
            shimmer: true,
          ),
        ],
      ),
    );
  }
}
