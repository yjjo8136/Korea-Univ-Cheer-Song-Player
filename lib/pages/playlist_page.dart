import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/playlist_play_bar.dart';
import 'package:korea_univ_cheer_song_player/components/playlist_song_tile.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:provider/provider.dart';

class PlaylistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final audioPlayer = context.watch<AudioPlayerNotifier>();
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 30),
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    '플레이리스트',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: _buildCloseButton(context),
                ),
              ],
            ),
            /*
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
            */

            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: audioPlayer.playlist.length,
                itemBuilder: (context, index) {
                  return PlaylistSongTile(
                    title: audioPlayer.playlist[index].title,
                    artist: audioPlayer.playlist[index].artist,
                    selected: audioPlayer.currentSong.title ==
                            audioPlayer.playlist[index].title
                        ? true
                        : false,
                  );
                },
              ),
            ),
            PlaylistPlayBar(isLyricPage: false),
          ],
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 50,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
