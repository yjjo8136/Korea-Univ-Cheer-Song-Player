import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/pages/playlist_page.dart';
import 'package:korea_univ_cheer_song_player/pages/song_detail_page.dart';
import 'package:provider/provider.dart';

class BottomPlayBar extends StatefulWidget {
  @override
  State<BottomPlayBar> createState() => _BottomPlayBarState();
}

class _BottomPlayBarState extends State<BottomPlayBar> {
  @override
  Widget build(BuildContext context) {
    final audioPlayer = context.watch<AudioPlayerNotifier>();

    return Column(
      children: [
        SizedBox(
          height: 4,
          width: double.infinity,
          child: Slider(
            activeColor: Color(0xFF7C001A),
            inactiveColor: Colors.grey,
            value: audioPlayer.position.inSeconds.toDouble(),
            min: 0.0,
            max: audioPlayer.duration.inSeconds.toDouble(),
            onChanged: (double value) {
              setState(() {
                Duration newDuration = Duration(seconds: value.toInt());
                audioPlayer.audioPlayer.seek(newDuration);
                value = value;
              });
            },
          ),
        ),
        Container(
          width: double.infinity,
          height: 70,
          color: Color(0xCC7C001A),
          child: Row(
            children: [
              Expanded(child: _buildPlayingSongInfo()),
              InkWell(
                child: Icon(Icons.skip_previous, size: 40),
                onTap: () {
                  audioPlayer.skipToPrevious();
                },
              ),
              InkWell(
                child: Icon(
                    audioPlayer.isPlaying == false
                        ? Icons.play_arrow
                        : Icons.pause,
                    size: 60),
                onTap: () async {
                  if (audioPlayer.isPlaying == false) {
                    audioPlayer.playAudio();
                  } else if (audioPlayer.isPlaying == true) {
                    audioPlayer.pauseAudio();
                  }
                },
              ),
              InkWell(
                child: Icon(Icons.skip_next, size: 40),
                onTap: () {
                  audioPlayer.skipToNext();
                },
              ),
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
        ),
      ],
    );
  }

  Widget _buildPlayingSongInfo() {
    final audioPlayer = context.watch<AudioPlayerNotifier>();
    if (audioPlayer.playlist.length == 0) {
      return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              "?????????????????????",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              "???????????? ??????????????????",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }
    return Consumer<AudioPlayerNotifier>(
      builder: (context, audioPlayerNotifier, child) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    audioPlayerNotifier.currentSong.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    audioPlayerNotifier.currentSong.artist,
                    style: TextStyle(
                      color: Color(0x80FFFFFF),
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SongDetailPage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
