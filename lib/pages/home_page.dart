import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 8, bottom: 16),
              child: Container(
                width: double.infinity,
                child: Text(
                  '인기 순위',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSongTile(),
                  _buildSongTile(),
                  _buildSongTile(),
                  _buildSongTile(),
                  _buildSongTile(),
                  _buildSongTile(),
                  _buildSongTile(),
                  _buildSongTile(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSongTile() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Color(0xFFDBBA81),
        ),
        width: double.infinity,
        height: 80,
        child: Row(
          children: [
            SizedBox(width: 25),
            Image.asset('assets/korea_univ_logo.png', height: 45, width: 45),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '1    민족의 아리아',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '          고려대학교',
                    style: TextStyle(
                      color: Color(0x4D000000),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Icon(Icons.play_arrow, size: 30),
            MoreInfoBottomSheet(title: '민족의 아리아', artist: '고려대학교', size: 30),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
