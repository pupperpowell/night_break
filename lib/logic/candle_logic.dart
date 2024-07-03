import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';

final pb = locator<PocketBase>();

class CandleLogic {
  List<RecordModel> candles = [];
  bool _isSubscribed = false;

  // idk what this does
  Function(RecordSubscriptionEvent)? onCandleUpdate;

  // get candles from database
  static Future<List<RecordModel>> fetchCandles() async {
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

  // get global candles
  List<RecordModel> getCandles() {
    return candles;
  }

  static Future<int> getTotalCandles() async {
    final resultList = await pb.collection('candles').getList();
    debugPrint('total candles:${resultList.items.length}');
    return resultList.items.length;
  }

  static Future<RecordModel?> createCandle(String RELATION_RECORD_ID) async {
    final body = <String, dynamic>{"owner": RELATION_RECORD_ID};
    try {
      final candleAttempt = await pb.collection('candles').create(body: body);
      return candleAttempt;
    } catch (e) {
      if (e is ClientException) {
        debugPrint('Error: ${e.response}');
        debugPrint('Status code: ${e.statusCode}');
      } else {
        debugPrint('Unexpected error: ${e.toString()}');
      }
      return null;
    }
  }

  void subscribeToCandleChanges() {
    if (_isSubscribed) return;
    pb.collection('candles').subscribe('*', (RecordSubscriptionEvent event) {
      debugPrint('Candle change: ${event.action}');
      debugPrint('Updated candle: ${event.record}');

      if (onCandleUpdate != null) {
        onCandleUpdate!(event);
        debugPrint("new candle event detected");
      }
    });
    debugPrint('subscribed to candle changes.');
    _isSubscribed = true;
  }

  void unsubscribeFromCandleChanges() {
    if (!_isSubscribed) return;

    pb.collection('candles').unsubscribe();
    debugPrint("no longer subscribed");
    _isSubscribed = false;
  }
}
