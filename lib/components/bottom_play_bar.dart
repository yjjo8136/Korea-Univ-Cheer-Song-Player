import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/pages/playlist_page.dart';

class BottomPlayBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Color(0xCC7C001A),
      child: Row(
        children: [
          _buildPlayingSongInfo(),
          Spacer(),
          Icon(Icons.skip_previous, size: 40),
          Icon(Icons.play_arrow, size: 60),
          Icon(Icons.skip_next, size: 40),
          SizedBox(width: 20),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlaylistPage(),
                  ),
                );
              },
              icon: Icon(Icons.playlist_play, size: 50),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildPlayingSongInfo() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '민족의 아리아',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '고려대학교',
            style: TextStyle(
              color: Color(0x80FFFFFF),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
