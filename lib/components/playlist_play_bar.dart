import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/pages/song_detail_page.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:provider/provider.dart';

class PlaylistPlayBar extends StatefulWidget {
  final bool isLyricPage;

  const PlaylistPlayBar({this.isLyricPage = true});

  @override
  State<PlaylistPlayBar> createState() => _PlaylistPlayBarState();
}

class _PlaylistPlayBarState extends State<PlaylistPlayBar> {
  Color repeatButtonColor = Colors.black;

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
            inactiveColor: Color(0x4DFFFFFF),
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
          height: 65,
          color: Color(0xFF7C001A),
          child: Row(
            children: [
              SizedBox(width: 30),
              InkWell(
                child: Icon(Icons.repeat,
                    size: 40,
                    color:
                        audioPlayer.isRepeat ? Colors.white : Colors.white38),
                onTap: () {
                  audioPlayer.toggleLoopMode();
                },
              ),
              Spacer(),
              InkWell(
                child: Icon(
                  Icons.skip_previous_rounded,
                  size: 40,
                  color: Colors.white,
                ),
                onTap: () {
                  audioPlayer.skipToPrevious();
                },
              ),
              Spacer(),
              InkWell(
                child: Icon(
                  audioPlayer.isPlaying == false
                      ? Icons.play_arrow_rounded
                      : Icons.pause,
                  size: 60,
                  color: Colors.white,
                ),
                onTap: () async {
                  if (audioPlayer.isPlaying == false) {
                    audioPlayer.playAudio();
                  } else if (audioPlayer.isPlaying == true) {
                    audioPlayer.pauseAudio();
                  }
                },
              ),
              Spacer(),
              InkWell(
                child: Icon(
                  Icons.skip_next_rounded,
                  size: 40,
                  color: Colors.white,
                ),
                onTap: () {
                  audioPlayer.skipToNext();
                },
              ),
              Spacer(),
              InkWell(
                child: Icon(
                  Icons.shuffle,
                  size: 40,
                  color: audioPlayer.isShuffle ? Colors.white : Colors.white38,
                ),
                onTap: () {
                  audioPlayer.toggleSuffleMode();
                },
              ),
              Spacer(),
              SizedBox(width: 10),
              widget.isLyricPage
                  ? _buildPlaylistButton(context)
                  : _buildSongDetailButton(context),
              SizedBox(width: 10),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSongDetailButton(BuildContext context) {
    return Consumer<AudioPlayerNotifier>(
      builder: (context, audioPlayerNotifier, child) {
        late CheerSong currentSong;
        for (int i = 0; i < songInfoList.length; i++) {
          if (songInfoList[i].title == audioPlayerNotifier.currentSong.title) {
            currentSong = songInfoList[i];
            break;
          }
        }
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SongDetailPage(),
              ),
            );
          },
          child: Image.asset(
              currentSong.artist == '고려대학교'
                  ? 'assets/images/korea_univ_logo.png'
                  : 'assets/images/yonsei_univ_logo.png',
              height: 45,
              width: 45),
        );
      },
    );
  }

  Widget _buildPlaylistButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
      child: Icon(Icons.playlist_play, size: 45, color: Colors.white),
    );
  }
}
