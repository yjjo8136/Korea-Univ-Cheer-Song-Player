import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/bottom_play_bar.dart';
import 'package:korea_univ_cheer_song_player/pages/home_page.dart';
import 'package:korea_univ_cheer_song_player/pages/like_page.dart';
import 'package:korea_univ_cheer_song_player/pages/search_page.dart';

class NavigationPage extends StatefulWidget {
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  static List<Widget> _pages = <Widget>[
    HomePage(),
    SearchPage(),
    LikePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: _pages.elementAt(_selectedIndex),
              height: 30,
            ),
          ),
          BottomPlayBar(),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      iconSize: 30,
      backgroundColor: Color(0xFF7C001A),
      showSelectedLabels: true, //selected item
      showUnselectedLabels: true, //unselected item
      selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
      unselectedIconTheme: IconThemeData(color: Colors.white, size: 27),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          activeIcon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search_outlined),
          activeIcon: Icon(Icons.search),
          label: '모든 응원가',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
          activeIcon: Icon(Icons.favorite),
          label: '좋아요',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
