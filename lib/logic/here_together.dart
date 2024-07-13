import 'dart:async';

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
   * And updates its own record every minute
   * 
   */

  const HereTogether({
    super.key,
  });

  @override
  HereTogetherState createState() => HereTogetherState();
}

class HereTogetherState extends State<HereTogether> {
  Timer? _timer;

  int _recentUsers = 0;
  int _activeUsers = 1;

  bool _isSubscribedToActiveUsers = false;

  @override
  void initState() {
    super.initState();
    markAsActive();
    _getRecentUsers();
    subscribeToActiveUsers();

    _getActiveUsers();
    _startTimer();
  }

  @override
  void dispose() {
    _stopTimer();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future<void> unsubscribe() async {
        if (_isSubscribedToActiveUsers) {
          try {
            await pb.collection('active_users').unsubscribe();
            debugPrint("Successfully unsubscribed from active users");
          } catch (e) {
            debugPrint("Error unsubscribing from active users: $e");
          } finally {
            _isSubscribedToActiveUsers = false;
          }
        }
      }

      Future.wait([
        unsubscribe().timeout(
          const Duration(seconds: 5),
          onTimeout: () {
            debugPrint("Unsubscribe timed out, forcing completion");
            _isSubscribedToActiveUsers = false;
          },
        ),
      ]);
    });

    super.dispose();
  }

  void _startTimer() {
    // Timer that fires every minute
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      markAsActive();
      _getRecentUsers();
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  Future<void> subscribeToActiveUsers() async {
    if (_isSubscribedToActiveUsers) return;
    pb.collection('active_users').subscribe('*', (e) {
      if (e.action == 'create' || e.action == 'update') {
        setState(() {
          _getActiveUsers();
        });
      }
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
    // get all records updated within 1 minute
    // and count them

    final now = DateTime.now().toUtc();
    final oneMinuteAgo = now.subtract(const Duration(minutes: 1));

    final activeUsers = await pb.collection('active_users').getList(
          page: 1,
          perPage: 50,
          filter: 'updated >= "$oneMinuteAgo"',
        );
    setState(() {
      _activeUsers = activeUsers.items.length;
      debugPrint('found $_activeUsers recent records');
    });
  }

  Future<void> _getRecentUsers() async {
    final now = DateTime.now().toUtc();
    final oneMinuteAgo = now.subtract(const Duration(minutes: 1));
    final fiveHoursAgo = now.subtract(const Duration(hours: 5));

    final recentUsers = await pb.collection('active_users').getList(
          page: 1,
          perPage: 500,
          filter: 'updated >= "$fiveHoursAgo" && updated < "$oneMinuteAgo"',
        );

    setState(() {
      _recentUsers = recentUsers.items.length;
    });
  }

  void _unsubscribeFromActiveUsers() {
    try {
      if (_isSubscribedToActiveUsers) {
        pb.collection('active_users').unsubscribe();
        _isSubscribedToActiveUsers = false;
      }
    } catch (e) {
      debugPrint('Error unsubscribing from active users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Text('$_activeUsers here now  |  $_recentUsers here recently',
        style: Theme.of(context).textTheme.bodyMedium);
  }
}
