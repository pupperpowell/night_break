import 'package:flutter/material.dart';
import 'package:night_break/components/candle.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Welcome to Night Break v0.9\nmade with love by George Powell',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                Candle(created: DateTime.now(), scale: 1.0, owner: "nobody"),
                const SizedBox(height: 32.0),
                const Text(
                  'This app is still in development. A small number of features are currently implemented or planned:',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                const ListItem(checked: true, text: 'candle stand'),
                const ListItem(
                    checked: false, text: 'anonymous prayer requests'),
                const ListItem(checked: false, text: 'daily readings'),
                const ListItem(
                    checked: false, text: 'synaxarion (saints of the day)'),
                const SizedBox(height: 16.0),
                const Text(
                  'After that, features will be added based on suggestions from the community.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16.0),
                const ListItem(checked: false, text: 'in-app feature requests'),
              ],
            ),
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
  void initState() {
    super.initState();
    isChecked = widget.checked;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 28.0,
      child: Row(
        children: [
          const SizedBox(width: 16.0),
          Checkbox(
            checkColor: Colors.white,
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value!;
              });
            },
          ),
          Text(widget.text,
              // style: Theme.of(context).textTheme.bodyLarge,
              style: const TextStyle(
                fontSize: 16.0,
                color: Color.fromARGB(255, 153, 188, 205),
              )),
        ],
      ),
    );
  }
}
