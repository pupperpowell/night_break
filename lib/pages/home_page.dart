import 'package:flutter/material.dart';
import 'package:night_break/components/candle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 32.0),
              const Text(
                'Welcome to Night Break v0.9\nmade with love by George Powell',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16.0),
              Candle(created: DateTime.now(), scale: 1.0, owner: "nobody"),
              const SizedBox(height: 32.0),
              const Text('This app is still in development.'),
              const ListItem(checked: true, text: 'candle stand'),
              const ListItem(checked: false, text: 'profile'),
            ],
          ),
        ),
      ),
    );
  }
}

class ListItem extends StatefulWidget {
  final bool checked;
  final String text;

  const ListItem({super.key, required this.checked, required this.text});

  @override
  State<ListItem> createState() => _ListItemState();
}

class _ListItemState extends State<ListItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          checkColor: Colors.white,
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        Text(widget.text, style: Theme.of(context).textTheme.bodyLarge),
      ],
    );
  }
}
