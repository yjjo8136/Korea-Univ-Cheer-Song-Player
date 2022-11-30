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
    return Column(
      children: [
        Slider(
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
        SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              audioPlayer.position.toString().split(".")[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C001A),
              ),
            ),
            Spacer(),
            Text(
              audioPlayer.duration.toString().split(".")[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0x80000000),
              ),
            ),
            SizedBox(width: 20),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              child: Icon(Icons.repeat,
                  size: 40,
                  color:
                      audioPlayer.isRepeat ? Color(0xFF7C001A) : Colors.black),
              onTap: () {
                audioPlayer.toggleLoopMode();
              },
            ),
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
              onTap: () {
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
            InkWell(
              child: Icon(
                Icons.shuffle,
                size: 40,
                color: audioPlayer.isShuffle ? Color(0xFF7C001A) : Colors.black,
              ),
              onTap: () {
                audioPlayer.toggleSuffleMode();
              },
            ),
          ],
        ),
      ],
    );
  }
}
