import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:provider/provider.dart';

class AudioFile extends StatefulWidget {
  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Color repeatButtonColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    final audioPlayer = context.watch<AudioPlayerNotifier>();
    String positionString = audioPlayer.position.toString().split(".")[0];
    String durationString = audioPlayer.duration.toString().split(".")[0];
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Column(
        children: [
          Slider(
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
          Row(
            children: [
              SizedBox(width: 25),
              Text(
                positionString.split(":")[1] +
                    ":" +
                    positionString.split(":")[2],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF7C001A),
                ),
              ),
              Spacer(),
              Text(
                durationString.split(":")[1] +
                    ":" +
                    durationString.split(":")[2],
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0x80000000),
                ),
              ),
              SizedBox(width: 25),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                child: Icon(Icons.repeat,
                    size: 40,
                    color: audioPlayer.isRepeat
                        ? Color(0xFF7C001A)
                        : Colors.black38),
                onTap: () {
                  audioPlayer.toggleLoopMode();
                },
              ),
              InkWell(
                child: Icon(
                  Icons.skip_previous_rounded,
                  size: 40,
                  color: Color(0xFF7C001A),
                ),
                onTap: () {
                  audioPlayer.skipToPrevious();
                },
              ),
              InkWell(
                child: Icon(
                  audioPlayer.isPlaying == false
                      ? Icons.play_arrow_rounded
                      : Icons.pause,
                  size: 60,
                  color: Color(0xFF7C001A),
                ),
                onTap: () {
                  if (audioPlayer.isPlaying == false) {
                    audioPlayer.playAudio();
                  } else if (audioPlayer.isPlaying == true) {
                    audioPlayer.pauseAudio();
                  }
                },
              ),
              InkWell(
                child: Icon(
                  Icons.skip_next_rounded,
                  size: 40,
                  color: Color(0xFF7C001A),
                ),
                onTap: () {
                  audioPlayer.skipToNext();
                },
              ),
              InkWell(
                child: Icon(
                  Icons.shuffle,
                  size: 40,
                  color: audioPlayer.isShuffle
                      ? Color(0xFF7C001A)
                      : Colors.black38,
                ),
                onTap: () {
                  audioPlayer.toggleShuffleMode();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
