import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Column(
              // title, logo, and subtitle
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 22.0),
                  child: Text(
                    'night break',
                    style: Theme.of(context).textTheme.displayLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 22.0),
                  child: Icon(
                    CupertinoIcons.moon_stars,
                    // for light mode: CupertinoIcons.moon_stars_fill
                    size: 64.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64.0),
                  child: Text(
                    'an app for the mbc staff community',
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
