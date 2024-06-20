import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sockeyway/screens/home/home.dart';
import 'package:sockeyway/screens/home/news.dart';
import 'package:sockeyway/screens/home/settings.dart';
import 'package:sockeyway/screens/home/tickets.dart';
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
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = user!.photoURL == 'Player'
        ? <Widget>[
            const HomePage(),
            const NewsPage(),
            const MatchesPage(),
            const SettingsPage(),
          ]
        : <Widget>[
            const HomePage(),
            const NewsPage(),
            const MatchesPage(),
            const TicketsPage(),
            const SettingsPage(),
          ];
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: user!.photoURL == 'Player'
              ? <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.flag),
                    label: 'News',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.sports_soccer),
                    label: 'Matches',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.more_vert),
                    label: 'More',
                  ),
                ]
              : <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.flag),
                    label: 'News',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.sports_soccer),
                    label: 'Matches',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.tickets),
                    label: 'Tickets',
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.more_vert),
                    label: 'More',
                  ),
                ],
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.primaryColor.withOpacity(0.5),
        ),
      ),
    );
  }
}
