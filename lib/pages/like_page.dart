import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/song_tile.dart';

class LikePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(height: 15),
              Text(
                '좋아요 목록',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
