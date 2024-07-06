import 'dart:math';

import 'package:flutter/widgets.dart';
// import 'package:night_break/components/sand.dart';
import 'package:pocketbase/pocketbase.dart';

import '../logic/candle_logic.dart';
import 'candle.dart';

/*
 * TODO:
 * 
 * - (DONE) build visible candle box container
 * - (DONE) fetch candles
 * - (DONE) subscribe to candles
 * -  (DONE) populate candles in box container
 *    - (postponed) give each candle a 'scale' parameter based on location within box
 * 
 * - add candles when collection is updated
 * - prevent add candle if user has an active candle already
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

  @override
  void initState() {
    super.initState();
    _populateCandles();

    // how should the UI respond if the candles db is updated?
  }

  @override
  void dispose() {
    super.dispose();
  }

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
    final random = Random(seed);

    // Create a list of candle positions with their respective widgets
    List<Map<String, dynamic>> candlePositions = candles.map((record) {
      final created = DateTime.parse(record.created);
      final x = 20 + random.nextDouble() * (boxSize.width - 40);
      final y = random.nextDouble() * boxSize.height / 4;
      final candle = Candle(
        created: created,
        scale: 1.0,
        owner: record.getStringValue('owner'),
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
    const double candleBoxHeight = 700;

    return SizedBox(
      width: candleBoxWidth,
      height: candleBoxHeight,
      child: Stack(
        children: [
          // const Positioned.fill(
          //   child: Sand(
          //     baseColor: Color.fromARGB(255, 181, 161, 130),
          //     secondaryColor: Color.fromARGB(255, 142, 122, 96),
          //   ),
          // ),
          ...positionCandlesRandomly(
            candles: candles,
            boxSize: Size(candleBoxWidth, candleBoxHeight),
            seed: 5,
          ),
        ],
      ),
    );
  }
}
