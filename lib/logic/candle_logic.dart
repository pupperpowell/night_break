import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';

final pb = locator<PocketBase>();

class CandleLogic {
  List<RecordModel> candles = [];
  bool _isSubscribed = false;

  RecordModel? Function(RecordSubscriptionEvent)? onCandleUpdate;

  void setOnCandleUpdate(
      RecordModel Function(RecordSubscriptionEvent) callback) {
    onCandleUpdate = callback;
  }

  // get candles from database
  static Future<List<RecordModel>> fetchCandles() async {
    final now = DateTime.now().toUtc();
    final fiveHoursAgo = now.subtract(const Duration(hours: 5));

    // fetch a paginated records list
    final resultList = await pb.collection('candles').getList(
          page: 1,
          perPage: 50,
          filter: 'created >= "$fiveHoursAgo"',
        );

    debugPrint('fetched recent candles: ${resultList.items.length}');
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

  static Future<bool> hasRecentCandle(String RELATION_RECORD_ID) async {
    final now = DateTime.now().toUtc();
    final fiveHoursAgo = now.subtract(const Duration(hours: 5));

    final resultList = await pb.collection('candles').getList(
          filter: 'owner = "$RELATION_RECORD_ID" && created >= "$fiveHoursAgo"',
          sort: '-created',
          page: 1,
          perPage: 1,
        );

    return resultList.items.isNotEmpty;
  }

  static Future<RecordModel?> createCandle(String RELATION_RECORD_ID) async {
    bool hasRecent = await hasRecentCandle(RELATION_RECORD_ID);
    if (hasRecent) {
      debugPrint('User has already created a candle in the last 5 hours');
      return null;
    }

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
    if (_isSubscribed) return; //prevents double subscribing
    pb.collection('candles').subscribe('*', (RecordSubscriptionEvent event) {
      debugPrint('candle detected by CandleLogic.subscribeToCandleChanges');

      if (event.action == 'create') {
        onCandleUpdate?.call(event); // Use ?.call to safely call if not null
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
