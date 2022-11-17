import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/playlist_play_bar.dart';
import 'package:korea_univ_cheer_song_player/text_style.dart';

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
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '민족의 아리아',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              '고려대학교',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLyric() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: ListView(
          children: [
            Text('타오르는 자유', style: lyricStyle),
            Text('나아가는 정의', style: lyricStyle),
            Text('솟구치는 진리', style: lyricStyle),
            Text('민족의 힘으로', style: lyricStyle),
          ],
        ),
      ),
    );
  }
}
