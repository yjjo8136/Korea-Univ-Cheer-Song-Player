import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/song_tile.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 15),
            Text(
              '응원가 검색',
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.search, size: 30),
                  SizedBox(width: 20),
                  Expanded(child: TextField()),
                  SizedBox(width: 10),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  SongTile(),
                  SongTile(),
                  SongTile(),
                  SongTile(),
                  SongTile(),
                  SongTile(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
