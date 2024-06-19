import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'about this app',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                text:
                    'Most apps are designed to be used by billions. But as it turns out, designing something for everybody is really designing something for... nobody. What features of Instagram, Facebook, or Snapchat really feel like they were designed specifically for',
                style: Theme.of(context).textTheme.bodyLarge,
                children: const <TextSpan>[
                  TextSpan(
                    text: ' you?\n',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            Text(
              "When you design something for only a few people in mind, you can tailor it to the needs of your community in ways that popular apps never could. So that's Night Break. It's designed specifically for the staff community of the Metropolis of Boston Camp. Every feature is crafted with our camp community in mind. When you use it, you'll see what I mean.\n",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "Looking for an invite code? Here's a hint: humility is not a pillar. That leaves you with six other options. I hope you enjoy this app!",
              style: Theme.of(context).textTheme.bodyLarge,
            )
          ],
        ),
      ),
    );
  }
}
