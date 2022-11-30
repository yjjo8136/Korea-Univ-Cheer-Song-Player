import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/full_lyric.dart';
import 'package:korea_univ_cheer_song_player/components/playlist_play_bar.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:provider/provider.dart';

class LyricDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                _buildSongTitle(),
                Spacer(),
                InkWell(
                  child: Icon(Icons.close, size: 30),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 20),
            _buildLyric(),
            PlaylistPlayBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSongTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Consumer<AudioPlayerNotifier>(
        builder: (context, audioPlayer, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  audioPlayer.currentSong.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  audioPlayer.currentSong.artist,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLyric() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: FullLyric(),
      ),
    );
  }
}
