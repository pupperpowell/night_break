import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

// TODO: Link to whatever tutorial i followed for this

class _NavBarState extends State<NavBar> {
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      onDestinationSelected: (int index) {
        setState(
          () {
            _currentPageIndex = index;
          },
        );
      },
      selectedIndex: _currentPageIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Symbols.favorite),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Symbols.candle_rounded),
          label: 'Candle Stand',
        ),
        NavigationDestination(
          icon: Icon(Symbols.settings),
          label: 'Settings',
        ),
      ],
      backgroundColor: Colors.black,
      height: 70,
    );
  }
}
