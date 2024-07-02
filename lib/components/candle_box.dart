import 'package:flutter/widgets.dart';
import 'package:night_break/components/sand.dart';
import 'package:night_break/locator.dart';
import 'package:pocketbase/pocketbase.dart';

import '../logic/candle_logic.dart';

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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 300,
      height: 150,
      child: Sand(
        graininess: 100.0,
        baseColor: Color.fromARGB(255, 181, 161, 130),
        secondaryColor: Color.fromARGB(255, 142, 122, 96),
      ),
    );
  }
}
