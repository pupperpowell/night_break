import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:night_break/components/sand.dart';
import 'package:pocketbase/pocketbase.dart';

import '../locator.dart';
import '../logic/candle_logic.dart';
import 'candle.dart';

/*
 * TODO:
 * 
 * - (DONE) build visible candle box container
 * - fetch candles
 * - subscribe to candles
 * - populate candles in box container
 *  - give each candle a 'scale' parameter based on location within box
 * - add candles when subscription is updated
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
  CandleLogic candleLogic = locator<CandleLogic>();
  List<RecordModel> candles = [];

  @override
  void initState() {
    super.initState();
    candles = candleLogic.getCandles();
    // _handleCandleUpdate();
    // how should the UI respond if the candles db is updated?
  }

  // void _handleCandleUpdate(RecordSubscriptionEvent event) {
  //   setState(() {
  //     if (event.action == 'create') {
  //       candles.add();
  //       // TODO: add a new candle to the box in real time
  //     } else if (event.action == 'delete') {
  //       candles.removeWhere((c) => c.id == event.record.id);
  //       // TODO?? remove a candle from the box in real time???
  //     }
  //   });
  // }

  List<Widget> positionCandlesRandomly({
    required List<RecordModel> records,
    required Size boxSize,
    required int seed,
  }) {
    final random = Random(seed);

    return records.map((record) {
      final created = DateTime.parse(record.created);
      final x = random.nextDouble() * boxSize.width;
      final y = random.nextDouble() * boxSize.height;
      final candle = Candle(
        created: created,
        scale: y / boxSize.height,
      );
      debugPrint('built a candle.');

      return Positioned(
        left: x,
        top: y,
        child: candle,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    const double candleWidth = 300;
    const double candleHeight = 150;

    return SizedBox(
      width: candleWidth,
      height: candleHeight,
      child: Stack(
        children: [
          const Positioned.fill(
            child: Sand(
              graininess: 100.0,
              baseColor: Color.fromARGB(255, 181, 161, 130),
              secondaryColor: Color.fromARGB(255, 142, 122, 96),
            ),
          ),
          ...positionCandlesRandomly(
            records: candles,
            boxSize: const Size(candleWidth, candleHeight),
            seed: 0,
          ),
        ],
      ),
    );
  }
}
