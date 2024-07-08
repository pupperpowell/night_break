import 'package:flutter/material.dart';

class CandleStandModal extends StatelessWidget {
  const CandleStandModal({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'what is this?',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20.0),
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.bodyMedium,
                children: const <TextSpan>[
                  TextSpan(
                    text:
                        'There is a river whose streams make glad the city of God, \nthe holy place where the Most High dwells. \nGod is within her, she will not fall; \nGod will help her at break of day.\n\n',
                  ),
                  TextSpan(text: '...He says, '),
                  TextSpan(
                      text: '"Be still, and know that I am God;',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text:
                          '\nI will be exalted among the nations, \nI will be exalted in the earth."'),
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
