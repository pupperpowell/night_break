import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: CupertinoFullscreenDialogTransition(
          primaryRouteAnimation: Animation,
          secondaryRouteAnimation: null,
          linearTransition: null,
          child: null,
        ),
      ),
    );
  }
}
