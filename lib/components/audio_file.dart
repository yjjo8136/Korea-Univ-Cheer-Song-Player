import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:provider/provider.dart';

class AudioFile extends StatefulWidget {
  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Color repeatButtonColor = Colors.black;
  List<IconData> _icons = [
    Icons.play_arrow,
    Icons.pause,
  ];

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
              child: Icon(Icons.repeat, size: 40, color: repeatButtonColor),
              onTap: () {
                if (audioPlayer.isRepeat == false) {
                  audioPlayer.audioPlayer.setReleaseMode(ReleaseMode.loop);

                  setState(() {
                    repeatButtonColor = Color(0xFF7C001A);
                  });
                } else if (audioPlayer.isRepeat == true) {
                  audioPlayer.audioPlayer.setReleaseMode(ReleaseMode.release);
                  setState(() {
                    repeatButtonColor = Colors.black;
                  });
                }
              },
            ),
            Icon(Icons.skip_previous, size: 40),
            InkWell(
              child: Icon(
                  audioPlayer.isPlaying == false ? _icons[0] : _icons[1],
                  size: 60),
              onTap: () async {
                if (audioPlayer.isPlaying == false) {
                  await audioPlayer.playAudio(audioPlayer.songPath);
                } else if (audioPlayer.isPlaying == true) {
                  audioPlayer.pauseAudio();
                }
              },
            ),
            Icon(Icons.skip_next, size: 40),
            Icon(Icons.shuffle, size: 40),
          ],
        ),
      ],
    );
  }
}
