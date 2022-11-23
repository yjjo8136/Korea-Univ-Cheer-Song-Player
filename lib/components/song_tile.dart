import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';
import 'package:korea_univ_cheer_song_player/notifier/playlist_notifier.dart';
import 'package:provider/provider.dart';

class SongTile extends StatelessWidget {
  final String title;
  final String artist;
  final bool playButtonIsVisible;

  const SongTile(
      {required this.title,
      required this.artist,
      this.playButtonIsVisible = true});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          SizedBox(width: 25),
          Image.asset('assets/korea_univ_logo.png', height: 45, width: 45),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  artist,
                  style: TextStyle(
                    color: Color(0x4D000000),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          playButtonIsVisible ? _buildPlayButton() : Container(),
          MoreInfoBottomSheet(title: title, artist: artist, size: 45),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  Widget _buildPlayButton() {
    return Consumer<PlaylistNotifier>(
      builder: (context, playlistNotifier, child) {
        return InkWell(
          child: Icon(Icons.play_arrow, size: 45),
          onTap: () {
            playlistNotifier.addPlaylist([title, artist]);
          },
        );
      },
    );
  }
}
