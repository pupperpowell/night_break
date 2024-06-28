import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';

final pb = locator<PocketBase>();

class CandleLogic {
  Function(RecordSubscriptionEvent)? onCandleUpdate;

  static Future<List<RecordModel>> getCandles() async {
    final now = DateTime.now();
    final sixHoursAgo = now.subtract(const Duration(hours: 6));

    // fetch a paginated records list
    final resultList = await pb.collection('candles').getList(
          page: 1,
          perPage: 50,
          filter: 'created >= "$sixHoursAgo"',
        );

    debugPrint('recent candles: ${resultList.items.length}');
    return resultList.items;
  }

  static Future<int> getTotalCandles() async {
    final resultList = await pb.collection('candles').getList();
    debugPrint('total candles:${resultList.items.length}');
    return resultList.items.length;
  }

  static Future<RecordModel> createCandle(String relationRecordId) async {
    return await pb.collection('candles').create(body: {
      'owner': relationRecordId,
    });
  }

  void subscribeToCandleChanges() {
    pb.collection('candles').subscribe('*', (RecordSubscriptionEvent event) {
      debugPrint('Candle change: ${event.action}');
      debugPrint('Updated candle: ${event.record}');

      if (onCandleUpdate != null) {
        onCandleUpdate!(event);
      }
    });
  }

  void unsubscribeFromCandleChanges() {
    pb.collection('candles').unsubscribe();
  }
}
