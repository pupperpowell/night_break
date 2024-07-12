import 'package:flutter/material.dart';

import 'candle_logic.dart';

class HereTogether extends StatefulWidget {
  /*
   * Recent users is passed to this method (candles.length)
   * Realtime connection to active_users is activated
   * On join, client 
   * - looks for a record with their username
   * - creates a new record if one doesn't exist
   * - if it does, updates the record... somehow
   * 
   * Then the client gets the total number of records updated within the past 3 minutes
   * And updates its own record every 3 minutes
   * 
   * TODO: set a timer to increment user record every 3 minutes
   * 
   */

  const HereTogether({
    super.key,
  });

  @override
  HereTogetherState createState() => HereTogetherState();
}

class HereTogetherState extends State<HereTogether> {
  int _recentUsers = 0;
  int _activeUsers = 1;

  bool _isSubscribedToActiveUsers = false;

  @override
  void initState() {
    super.initState();
    _getRecentUsers(); // candles.length
    subscribeToActiveUsers(); //
    markAsActive();
    _getActiveUsers();
  }

  @override
  void dispose() {
    _unsubscribeFromActiveUsers();
    super.dispose();
  }

  Future<void> subscribeToActiveUsers() async {
    if (_isSubscribedToActiveUsers) return;
    pb.collection('active_users').subscribe('*', (e) {
      // if any creation or update is made to the active_users collection
      // uhhhh update the state or something, i'm on the phone.
    });
    _isSubscribedToActiveUsers = true;
  }

  Future<void> markAsActive() async {
    try {
      final record = await pb.collection('active_users').getFirstListItem(
            'owner="${pb.authStore.model.id}"',
          );
      // record found, update it
      await pb.collection('active_users').update(record.id, body: {
        'updates': (record.data['updates'] ?? 0) + 1,
      });
      debugPrint('Updated active user record: ${record.id}');
    } catch (e) {
      //
      final data = {
        'owner': pb.authStore.model.id,
      };

      try {
        final newRecord =
            await pb.collection('active_users').create(body: data);
        debugPrint('Created new active user record: ${newRecord.id}');
      } catch (createError) {
        debugPrint('Error creating new record: $createError');
      }
    }
  }

  Future<void> _getActiveUsers() async {
    // get all records updated within 3 minutes
    // and count them

    final now = DateTime.now().toUtc();
    final threeMinutesAgo = now.subtract(const Duration(minutes: 3));

    final activeUsers = await pb.collection('active_users').getList(
          page: 1,
          perPage: 50,
          filter: 'updated >= "$threeMinutesAgo"',
        );
    setState(() {
      _activeUsers = activeUsers.items.length;
    });
  }

  Future<void> _getRecentUsers() async {
    CandleLogic.fetchCandles().then((fetchedCandles) {
      setState(() {
        _recentUsers = fetchedCandles.length;
      });
    });
  }

  void _unsubscribeFromActiveUsers() {
    pb.collection('active_users').unsubscribe();
    _isSubscribedToActiveUsers = false;
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_activeUsers here now | $_recentUsers here recently',
        style: Theme.of(context).textTheme.bodyMedium);
  }
}
