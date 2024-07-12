import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:pocketbase/pocketbase.dart';

import '../logic/candle_logic.dart';
import 'candle.dart';

/*
 * 
 * - (DONE) build visible candle box container
 * - (DONE) fetch candles
 * - (DONE) subscribe to candles
 * -  (DONE) populate candles in box container
 *    - (postponed) give each candle a 'scale' parameter based on location within box
 * 
 * - (DONE) add candles when collection is updated
 * - (DONE) prevent add candle if user has an active candle already
 * 
 */

class CandleBox extends StatefulWidget {
  const CandleBox({
    super.key,
  });

  @override
  CandleBoxState createState() => CandleBoxState();
}

class CandleBoxState extends State<CandleBox> {
  static List<RecordModel> candles = [];
  Map<String, DateTime> candleAddTimes = {};

  int activeUsers = 0; // TODO: This is not updating in UI

  CandleLogic candleLogic = CandleLogic();

  @override
  void initState() {
    super.initState();

    // add a candle to the list if the user creates one
    candleLogic.onCandleUpdate = (event) {
      if (event.record != null) {
        setState(() {
          candles.add(event.record!);
          candleAddTimes[event.record!.id] = DateTime.now().toUtc();
        });
      }
      return event.record;
    };
    candleLogic.subscribeToCandleChanges();
    _subscribeToActiveUsers(); // not running?
    _populateCandles();
  }

  @override
  void dispose() {
    candleLogic.unsubscribeFromCandleChanges();
    _unsubscribeFromActiveUsers();
    super.dispose();
  }

  // TODO: This is not running on init
  void _subscribeToActiveUsers() {
    pb.collection('active_users').subscribe('*', (e) {
      if (e.record != null) {
        setState(() {
          activeUsers = e.record!.getIntValue('in_quiet_room');
        });
        debugPrint('found $activeUsers people');
        _incrementActiveUsers();
      }
    });
  }

  void _unsubscribeFromActiveUsers() {
    pb.collection('active_users').unsubscribe();
  }

  Future<void> _incrementActiveUsers() async {
    try {
      final record = await pb.collection('active_users').getFirstListItem('');
      await pb.collection('active_users').update(record.id, body: {
        'in_quiet_room': record.getIntValue('in_quiet_room') + 1,
      });
      debugPrint('incremented to ${record.getIntValue('in_quiet_room') + 1}');
    } catch (e) {
      debugPrint('Error incrementing active users: $e');
    }
  }

  // fill up the list of candles this widget holds
  void _populateCandles() {
    CandleLogic.fetchCandles().then((fetchedCandles) {
      setState(() {
        candles = fetchedCandles;
      });
    });
  }

  List<Widget> positionCandlesRandomly({
    required List<RecordModel> candles,
    required Size boxSize,
    required int seed,
  }) {
    debugPrint('drawing candles to screen');
    final random = Random(seed);

    // Create a list of candle positions with their respective widgets
    List<Map<String, dynamic>> candlePositions = candles.map((record) {
      final created = DateTime.parse(record.created);
      final x = 20 + random.nextDouble() * (boxSize.width - 40);
      final y = random.nextDouble() * boxSize.height / 4;
      final addTime = candleAddTimes[record.id] ?? DateTime.now().toUtc();
      final candle = Candle(
        key: ValueKey(record.id),
        created: created,
        scale: 1.0,
        owner: record.getStringValue('owner'),
        fadeIn: DateTime.now().difference(addTime).inSeconds < 5,
      );

      return {
        'x': x,
        'y': y,
        'widget': candle,
      };
    }).toList();

    // Sort the list based on y-position, from highest to lowest
    candlePositions.sort((a, b) => a['y'].compareTo(b['y']));

    // Create Positioned widgets from the sorted list
    return candlePositions.map((candleData) {
      return Positioned(
        left: candleData['x'],
        top: candleData['y'],
        child: candleData['widget'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('got ${candles.length} candles');

    double candleBoxWidth = MediaQuery.sizeOf(context).width;
    const double candleBoxHeight = 450;

    return Column(
      children: [
        Text('$activeUsers here now'), // TODO: set to normal theme
        const SizedBox(height: 72.0),
        SizedBox(
          width: candleBoxWidth,
          height: candleBoxHeight,
          child: Stack(
            children: [
              ...positionCandlesRandomly(
                candles: candles,
                boxSize: Size(candleBoxWidth, candleBoxHeight),
                seed: DateTime.now().month * 31 + DateTime.now().day,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
