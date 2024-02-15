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
          primaryRouteAnimation: const AlwaysStoppedAnimation<double>(0),
          secondaryRouteAnimation: const AlwaysStoppedAnimation<double>(1),
          linearTransition: false,
          child: const Text('about this app'),
          // TODO: fix this, it doesn't work at all.
        ),
      ),
    );
  }
}
