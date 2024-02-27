import 'package:flutter/material.dart';

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
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        NavigationDestination(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
