import 'package:flutter/material.dart';
import 'package:sockeyway/screens/home/home.dart';
import 'package:sockeyway/screens/home/news.dart';
import 'package:sockeyway/screens/home/settings.dart';
import 'package:sockeyway/utils/colors.dart';

import 'matches.dart';

class WelcomePage extends StatefulWidget {
  final dynamic username;
  const WelcomePage({super.key, this.username});

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const NewsPage(),
    const MatchesPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.flag),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: 'Matches',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.more_vert),
            label: 'More',
          ),
        ],
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.primaryColor.withOpacity(0.5),
      ),
    );
  }
}
