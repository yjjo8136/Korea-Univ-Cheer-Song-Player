import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/pages/song_detail_page.dart';

class PlaylistPlayBar extends StatelessWidget {
  final bool isLyricPage;

  const PlaylistPlayBar({this.isLyricPage = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      color: Color(0xFF7C001A),
      child: Row(
        children: [
          Icon(Icons.repeat, size: 40),
          Spacer(),
          Icon(Icons.skip_previous, size: 40),
          Spacer(),
          Icon(Icons.play_arrow, size: 60),
          Spacer(),
          Icon(Icons.skip_next, size: 40),
          Spacer(),
          Icon(Icons.shuffle, size: 40),
          Spacer(),
          SizedBox(width: 10),
          isLyricPage ? _buildPlaylistButton(context) : _buildSongDetailButton(context),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildSongDetailButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SongDetailPage(),
          ),
        );
      },
      child: Image.asset('assets/korea_univ_logo.png',
          height: 45, width: 45),
    );
  }

  Widget _buildPlaylistButton(BuildContext context){
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Icon(Icons.playlist_play, size: 45),
    );
  }
}
