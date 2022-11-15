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
      showSelectedLabels: false, //selected item
      showUnselectedLabels: false, //unselected item
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.white,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '홈',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: '검색',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite_border),
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
