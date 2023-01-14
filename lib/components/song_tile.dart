import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:provider/provider.dart';

class SongTile extends StatefulWidget {
  final String title;
  final String artist;

  const SongTile({
    required this.title,
    required this.artist,
  });

  @override
  State<SongTile> createState() => _SongTileState();
}

class _SongTileState extends State<SongTile> {
  @override
  Widget build(BuildContext context) {
    late CheerSong currentSong;
    for (int i = 0; i < songInfoList.length; i++) {
      if (songInfoList[i].title == widget.title) {
        currentSong = songInfoList[i];
        break;
      }
    }

    return Container(
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          SizedBox(width: 40),
          Image.asset(
              currentSong.artist == '고려대학교'
                  ? 'assets/images/korea_univ_logo.png'
                  : 'assets/images/yonsei_univ_logo.png',
              height: 45,
              width: 45),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  widget.artist,
                  style: TextStyle(
                    color: Color(0x4D000000),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          _buildPlayButton(currentSong),
          MoreInfoBottomSheet(
              title: widget.title, artist: widget.artist, size: 25),
          SizedBox(width: 25),
        ],
      ),
    );
  }

  Widget _buildPlayButton(CheerSong currentSong) {
    return Consumer<AudioPlayerNotifier>(
      builder: (context, audioPlayerNotifier, child) {
        return InkWell(
          child: Icon(
            Icons.play_arrow_rounded,
            size: 45,
            color: Color(0xFF7C001A),
          ),
          onTap: () {
            audioPlayerNotifier.addToPlaylist(currentSong);
            audioPlayerNotifier.playAudio();
          },
        );
      },
    );
  }
}
