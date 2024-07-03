import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:night_break/components/sand.dart';
import 'package:pocketbase/pocketbase.dart';

import '../logic/candle_logic.dart';
import 'candle.dart';

/*
 * TODO:
 * 
 * - (DONE) build visible candle box container
 * - (DONE) fetch candles
 * - (DONE) subscribe to candles
 * -  populate candles in box container
 *    - give each candle a 'scale' parameter based on location within box
 * - add candles when subscription is updated
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
    debugPrint('current candles: ${candles.toString()}');
    // _handleCandleUpdate();
    // how should the UI respond if the candles db is updated?
  }

  @override
  void dispose() {
    super.dispose();
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

    return candles.map((record) {
      final created = DateTime.parse(record.created);
      final x = random.nextDouble() * boxSize.width / 1.5;
      final y = random.nextDouble() * boxSize.height / 2;
      final candle = Candle(
        created: created,
        scale: 0.8 + (y / boxSize.height) * (0.2),
      );

      return Positioned(
        left: x,
        top: y,
        child: candle,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('got ${candles.length} candles');

    const double candleBoxWidth = 300;
    const double candleBoxHeight = 300;

    return SizedBox(
      width: candleBoxWidth,
      height: candleBoxHeight,
      child: Stack(
        children: [
          const Positioned.fill(
            child: Sand(
              baseColor: Color.fromARGB(255, 181, 161, 130),
              secondaryColor: Color.fromARGB(255, 142, 122, 96),
            ),
          ),
          ...positionCandlesRandomly(
            candles: candles,
            boxSize: const Size(candleBoxWidth, candleBoxHeight),
            seed: 0,
          ),
        ],
      ),
    );
  }
}
