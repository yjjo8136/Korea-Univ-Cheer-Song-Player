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
            SizedBox(height: 40),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _buildSongTitle(),
                ),
                Positioned(
                  top: -15,
                  right: 15,
                  child: _buildCloseButton(context),
                ),
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
    return Consumer<AudioPlayerNotifier>(
      builder: (context, audioPlayer, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              audioPlayer.currentSong.artist == '고려대학교'
                  ? 'assets/images/korea_univ_logo.png'
                  : 'assets/images/yonsei_univ_logo.png',
              height: 35,
              width: 35,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  audioPlayer.currentSong.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 3),
                Text(
                  audioPlayer.currentSong.artist,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        );
      },
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

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          Icons.close,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
