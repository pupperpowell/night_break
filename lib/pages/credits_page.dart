import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsPage extends StatelessWidget {
  const CreditsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kolophon'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Night Break',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 0.0),
              Text(
                'Version: 1.0',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 24),
              Text(
                'Inspirations:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              Row(children: [
                const Text('• '),
                GestureDetector(
                  onTap: () => launchUrl(Uri.parse('https://sit.sonnet.io/')),
                  child: const Text(
                    'Sit',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.lightBlue,
                    ),
                  ),
                ),
                const Text(' by Rafał Pastuszak'),
              ]),
              Row(
                children: [
                  const Text('• Anthropological writings of '),
                  GestureDetector(
                    onTap: () => launchUrl(
                        Uri.parse('https://maggieappleton.com/essays')),
                    child: const Text(
                      'Maggie Appleton',
                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlue,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text('• '),
                  GestureDetector(
                    onTap: () =>
                        launchUrl(Uri.parse('https://runyourown.social/')),
                    child: const Text('Run your own social',
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.lightBlue)),
                  ),
                  const Text(' by Darius Kazemi'),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                'Attributions:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Text(
                  '• Church bells by Arnaud Coutancier\n   License: Attribution NonCommercial 3.0'),
              const Text(
                  '• Single Jingle Bells Shaking 011 by Wastefield\n   License: Creative Commons 0'),
              const SizedBox(height: 24),
              Text(
                'Code by:',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const Text('• George Powell'),
              GestureDetector(
                onTap: () => launchUrl(
                    Uri.parse('https://github.com/pupperpowell/night_break')),
                child: const Text('Link to code repository',
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Colors.lightBlue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
