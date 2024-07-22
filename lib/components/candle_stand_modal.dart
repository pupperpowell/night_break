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
            const Text(
              '"Be still, and know that I am God..."',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const Text(
              'Psalm 46:10',
            ),
            const SizedBox(height: 20.0),
            const Text(
                'Do you find yourself scrolling through social media for hours? Take a break and light a candle here. When other people join, their candles will appear as well.'),
            const SizedBox(height: 20.0),
            const Text(
              'Warning: Audio will play in the next screen. Many will recognize the sounds that play. To mute, turn your phone\'s volume down.',
              //style: ,
            ),
            // const Padding(
            //   padding: EdgeInsets.all(18.0),
            //   child: Column(
            //     children: [
            //       Text(
            //         '"The highest form of prayer is to stand silently in awe before God"',
            //         textAlign: TextAlign.center,
            //         style: TextStyle(fontWeight: FontWeight.bold),
            //       ),
            //       Text('St. Isaac the Syrian'),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
