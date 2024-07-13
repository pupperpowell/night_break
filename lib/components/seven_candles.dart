import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SevenCandles extends StatelessWidget {
  final Future<int> weeklyCandleCount;

  const SevenCandles({super.key, required this.weeklyCandleCount});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: weeklyCandleCount,
      builder: (context, snapshot) {
        const Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Symbols.mode_heat_off,
            ),
            Icon(
              Symbols.mode_heat_off,
            ),
            Icon(
              Symbols.mode_heat_off,
            ),
            Icon(
              Symbols.mode_heat_off,
            ),
            Icon(
              Symbols.mode_heat_off,
            ),
            Icon(
              Symbols.mode_heat_off,
            ),
            Icon(
              Symbols.mode_heat_off,
            ),
          ],
        );
      },
    );
  }
}
