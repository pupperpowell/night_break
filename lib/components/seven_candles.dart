import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:pocketbase/pocketbase.dart';

import '../logic/candle_logic.dart';

class SevenCandles extends StatelessWidget {
  const SevenCandles({super.key});

  Future<List<RecordModel>> getUserCandles() async {
    final resultList = await pb.collection('candles').getList(
          filter: 'owner = "${pb.authStore.model.id}"',
          sort: '-created',
        );
    debugPrint('got a list of candles for user');
    return resultList.items;
  }

  int numberOfCandles(List<RecordModel> candles) {
    debugPrint('total candles: ${candles.length}');
    return candles.length;
  }

  int calculateStreak(List<RecordModel> candles) {
    if (candles.isEmpty) return 0;

    int streak = 1;
    DateTime mostRecentCandleDate =
        DateTime.parse(candles.first.created).toLocal();
    DateTime today = DateTime.now().toLocal();

    for (int i = 0; i < candles.length; i++) {
      DateTime candleDate = DateTime.parse(candles[i].created).toLocal();
      DateTime nextCandleDate =
          DateTime.parse(candles[i + 1].created).toLocal();

      if (candleDate.day == nextCandleDate.day &&
          candleDate.month == nextCandleDate.month &&
          candleDate.year == nextCandleDate.year) {
        continue; // Skip duplicate entries for the same day
      }

      if (nextCandleDate.day == candleDate.day + 1) {
        streak++;
      }

      // stop counting if the streak is broken
    }

    // Check if the streak includes today
    // if (lastDate.year == today.year &&
    //     lastDate.month == today.month &&
    //     lastDate.day == today.day) {
    //   streak++;
    // }
    debugPrint('streak: $streak');
    return streak;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecordModel>>(
      future: getUserCandles(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          int streak = calculateStreak(snapshot.data!);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  double iconSize = constraints.maxWidth / 7;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(7, (index) {
                      return Icon(
                        Symbols.mode_heat,
                        color: index < streak ? Colors.orange : Colors.grey,
                        size: iconSize,
                      );
                    }),
                  );
                },
              ),
              const SizedBox(height: 16.0),
              Text('${numberOfCandles(snapshot.data!)} candles lit'),
            ],
          );
        } else {
          return const Text('Couldn\'t get candle data');
        }
      },
    );
  }
}
