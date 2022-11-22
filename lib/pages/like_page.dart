import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/song_tile.dart';
import 'package:korea_univ_cheer_song_player/liked_notifier.dart';
import 'package:provider/provider.dart';

class LikePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final likedSongList = context.watch<LikedNotifier>().likedSongList;

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
                child: ListView.builder(
                  itemCount: likedSongList.length,
                  itemBuilder: (context, index) {
                    return SongTile(
                      title: likedSongList[index][0],
                      artist: likedSongList[index][1],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
