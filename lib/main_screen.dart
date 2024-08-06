import 'package:eco_focus/features/home/home_screen.dart';
import 'package:eco_focus/features/settings/settings_screen.dart';
import 'package:eco_focus/features/startSession/start_session_screen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pageController = PageController(initialPage: 0);

  int _selectedIndex = 0;

  void _onChangedTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _screenList = <Widget>[
    HomeScreen(),
    StartSessionScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_rounded), label: 'Focus'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onChangedTab,
      ),
      body: _screenList.elementAt(_selectedIndex),
    );
  }
}
