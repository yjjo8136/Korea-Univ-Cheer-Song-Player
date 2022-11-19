import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioFile extends StatefulWidget {
  final AudioPlayer advancedPlayer;

  const AudioFile({Key? key, required this.advancedPlayer}) : super(key: key);

  @override
  State<AudioFile> createState() => _AudioFileState();
}

class _AudioFileState extends State<AudioFile> {
  Duration _duration = new Duration();
  Duration _position = new Duration();
  final String path = 'aria.mp3';
  bool isPlaying = false;
  bool isPaused = false;
  bool isLoop = false;
  List<IconData> _icons = [
    Icons.play_arrow,
    Icons.pause,
  ];

  @override
  void initState() {
    super.initState();

    widget.advancedPlayer.onDurationChanged.listen((d) {
      setState(() {
        _duration = d;
      });
    });
    widget.advancedPlayer.onPositionChanged.listen((p) {
      setState(() {
        _position = p;
      });
    });

    widget.advancedPlayer.setSource(AssetSource(path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Slider(
          activeColor: Color(0xFF7C001A),
          inactiveColor: Colors.grey,
          value: _position.inSeconds.toDouble(),
          min: 0.0,
          max: _duration.inSeconds.toDouble(),
          onChanged: (double value) {
            setState(() {
              Duration newDuration = Duration(seconds: value.toInt());
              widget.advancedPlayer.seek(newDuration);
              value = value;
            });
          },
        ),
        SizedBox(height: 5),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              _position.toString().split(".")[0],
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF7C001A),
              ),
            ),
            Spacer(),
            Text(
              _duration.toString().split(".")[0],
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
            Icon(Icons.repeat, size: 40),
            Icon(Icons.skip_previous, size: 40),
            InkWell(
              child: Icon(isPlaying == false ? _icons[0] : _icons[1], size: 60),
              onTap: () async {
                if (isPlaying == false) {
                  await widget.advancedPlayer.play(AssetSource(path));
                  setState(() {
                    isPlaying = true;
                  });
                } else if (isPlaying == true) {
                  widget.advancedPlayer.pause();
                  setState(() {
                    isPlaying = false;
                  });
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
