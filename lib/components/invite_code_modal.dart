import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:provider/provider.dart';

import '../auth/signup_page.dart';
import '../locator.dart';
import 'auth_text_field.dart';
import '../logic/invite_code_logic.dart';

class InviteCodeModal extends StatefulWidget {
  const InviteCodeModal({super.key});

  @override
  State<InviteCodeModal> createState() => _InviteCodeModalState();
}

class _InviteCodeModalState extends State<InviteCodeModal> {
  bool verifyEnabled = false;
  final _inviteCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _inviteCodeController.addListener(() {
      _checkVerifyStatus();
    });
  }

  void _checkVerifyStatus() {
    setState(() {
      // verifyEnabled = _inviteCodeController.text.isNotEmpty;
      verifyEnabled = isValidInviteCode(_inviteCodeController.text);
    });
  }

  bool isValidInviteCode(String text) {
    final regex = RegExp(r"^[a-z]+-[a-z]+-[0-9]+$");
    return regex.hasMatch(text);
  }

  @override
  void dispose() {
    _inviteCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pb = locator<PocketBase>();
    return SingleChildScrollView(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AuthTextField(
                controller: _inviteCodeController,
                hintText: 'code',
                obscureText: false,
                shimmer: true,
              ),
              const SizedBox(height: 24.0),
              CupertinoButton.filled(
                onPressed: verifyEnabled
                    ? () async {
                        final String enteredCode =
                            _inviteCodeController.text.toString();
                        Future<bool> result = verifyInviteCode(
                          enteredCode,
                          pb,
                        );
                        if (await result) {
                          Navigator.pop(context); // dismiss modal
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SignupPage(inviteCode: enteredCode),
                            ),
                          );
                        } else {
                          // invalid invite code, show cupertino dialogue
                          showCupertinoDialog(
                            context: context,
                            builder: (context) => CupertinoAlertDialog(
                              title: const Text('invalid invite code'),
                              content:
                                  const Text('maybe someone already used it?'),
                              actions: [
                                CupertinoDialogAction(
                                  child: const Text('ok'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            ),
                          );
                        }
                      }
                    : null,
                child: const Text('verify'),
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
