import 'package:flutter/material.dart';

class AboutModal extends StatelessWidget {
  const AboutModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
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
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text:
                        '"In trying to build a service for everyone, it often feels like we\'re not focused on anyone in particular…"\n',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const TextSpan(
                    text: '—',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text: 'Mark Zuckerberg, on building Facebook',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  const TextSpan(text: '\n\n'),
                  const TextSpan(
                    text: 'Night Break',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const TextSpan(
                    text:
                        ' is an app made specifically with the greater Metropolis of Boston Camp community in mind; staff, friends, relatives, parents, campers, clergy, friends of friends, and more.\n\n',
                  ),
                  const TextSpan(
                    text:
                        'I believe building for a community, instead of for \'everyone,\' has a huge impact on the design, engineering, and messaging of any product or service. Every feature of this app is tailor-made with you in mind.\n\n',
                  ),
                  const TextSpan(
                    text:
                        'It has been a gift to be able to build and handcraft this app for you, from conception to reality. Thank you for being my motivation and guiding light.\n\n',
                  ),
                  const TextSpan(
                    text:
                        'Looking for an invite code? Here\'s a hint– humility is not a pillar. (There are six other options.)\n\n',
                  ),
                  const TextSpan(
                    text: 'Love,\n',
                  ),
                  TextSpan(
                    text: 'George Powell',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18.0),
          ],
        ),
      ),
    );
  }
}
