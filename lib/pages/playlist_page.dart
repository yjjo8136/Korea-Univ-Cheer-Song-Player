import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/playlist_play_bar.dart';
import 'package:korea_univ_cheer_song_player/components/song_tile.dart';

class PlaylistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 15),
            Text(
              '플레이리스트',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.search, size: 30),
                  Spacer(),
                  Text(
                    '편집',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 20),
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
            ),
            PlaylistPlayBar(),
          ],
        ),
      ),
    );
  }
}