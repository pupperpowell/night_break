import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'quiet_room.dart';

class CandleStandPage extends StatefulWidget {
  const CandleStandPage({super.key});

  @override
  CandleStandPageState createState() => CandleStandPageState();
}

class CandleStandPageState extends State<CandleStandPage> {
// https://docs.flutter.dev/ui/layout

  int _minuteGoal = 1;

  void _showTimeDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('welcome to the candle stand'),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('I want to be here for '),
                CupertinoButton(
                  minSize: 0,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 4.0),
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(24.0),
                  // Display a CupertinoPicker with list of numbers.
                  onPressed: () => _showTimeDialog(
                    CupertinoPicker(
                      magnification: 1.22,
                      squeeze: 1.2,
                      useMagnifier: true,
                      itemExtent: 32,
                      // This sets the initial item.
                      scrollController: FixedExtentScrollController(
                        initialItem: _minuteGoal - 1,
                      ),
                      // This is called when selected item is changed.
                      onSelectedItemChanged: (int selectedItem) {
                        setState(() {
                          _minuteGoal = selectedItem + 1;
                        });
                      },
                      children: List<Widget>.generate(10, (int index) {
                        return Center(child: Text('${index + 1}'));
                      }),
                    ),
                  ),
                  // This displays the selected number.
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _minuteGoal == 1
                            ? '$_minuteGoal minute'
                            : '$_minuteGoal minutes',
                      ),
                      const SizedBox(width: 4.0),
                      const Icon(CupertinoIcons.chevron_down, size: 12.0),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32.0),
            CupertinoButton.filled(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const QuietRoom()),
                );
                // show the dialog for quiet room
                showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                    title: const Text('take a moment to be still'),
                    content: const Padding(
                      padding: EdgeInsets.all(6.0),
                      child: Column(
                        children: [
                          Text(
                              'Important: please leave this app open or else it won\'t work!'),
                          SizedBox(height: 6.0),
                          Text(
                              'a sound will play when your time is up, and every minute after that.'),
                          SizedBox(height: 6.0),
                          Text("enjoy :)"),
                        ],
                      ),
                    ),
                    actions: [
                      CupertinoDialogAction(
                        isDefaultAction: true,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('okay'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('light a candle'),
            ),
            const SizedBox(height: 16.0),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
