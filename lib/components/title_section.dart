import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleSection extends StatelessWidget {
  const TitleSection({super.key});

/* 
 * TitleSection is the top part of the welcome screen.
 * It contains a title, logo/icon, and subtitle
 * It is called in WelcomePage (welcome_page.dart)
 */

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
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
