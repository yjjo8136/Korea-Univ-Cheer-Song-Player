import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:provider/provider.dart';

class PlaylistSongTile extends StatefulWidget {
  final String title;
  final String artist;
  final bool selected;

  const PlaylistSongTile({
    required this.title,
    required this.artist,
    this.selected = false,
  });

  @override
  State<PlaylistSongTile> createState() => _PlaylistSongTileState();
}

class _PlaylistSongTileState extends State<PlaylistSongTile> {
  @override
  Widget build(BuildContext context) {
    final audioPlayer = context.watch<AudioPlayerNotifier>();

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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: InkWell(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyle(
                        color:
                            widget.selected ? Color(0xFF7C001A) : Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      widget.artist,
                      style: TextStyle(
                        color: widget.selected
                            ? Color(0x4D7C001A)
                            : Color(0x4D000000),
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  audioPlayer.changePlaylistIndex(currentSong);
                  audioPlayer.playAudio();
                },
              ),
            ),
          ),
          MoreInfoBottomSheet(
            title: widget.title,
            artist: widget.artist,
            size: 25,
            showDeleteFromPlaylist: true,
          ),
          SizedBox(width: 25),
        ],
      ),
    );
  }
}
