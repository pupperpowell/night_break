import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../components/candle_stand_modal.dart';

import '../logic/candle_logic.dart';
import 'quiet_room.dart';

class CandleStandPage extends StatefulWidget {
  const CandleStandPage({super.key});

  @override
  CandleStandPageState createState() => CandleStandPageState();
}

class CandleStandPageState extends State<CandleStandPage> {
// https://docs.flutter.dev/ui/layout

  int _minuteGoal = 1;

  // are these needed in this class?
  late CandleLogic candleLogic;
  List<RecordModel> candles = [];

  @override
  void initState() {
    super.initState();
  }

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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Text('candle stand',
                  style: Theme.of(context).textTheme.displayMedium),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'I want to be still for ',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
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
                          return Center(
                            child: Text('${index + 1}',
                                style: Theme.of(context).textTheme.titleLarge),
                          );
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
                    PageRouteBuilder(
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                      transitionDuration: const Duration(seconds: 1),
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return QuietRoom(
                          minuteGoal: _minuteGoal,
                        );
                      },
                    ),
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
                            SizedBox(height: 6.0),
                            Text('feel free to put your phone down.'),
                            SizedBox(height: 12.0),
                            Text(
                                'a sound will play when your time is up, and every minute after that.'),
                            SizedBox(height: 6.0),
                            Text(
                                "if you leave early, a candle won't be lit..."),
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
                child: const Text('visit the candle stand'),
              ),
              const Spacer(),
              CupertinoButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    showDragHandle: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.black.withOpacity(0.9),
                    builder: (context) => const CandleStandModal(),
                  );
                },
                child: const Text('what is this?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
