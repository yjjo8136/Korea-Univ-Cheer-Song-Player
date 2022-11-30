import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:lrc/lrc.dart';
import 'package:provider/provider.dart';

class FullLyric extends StatefulWidget {
  const FullLyric({Key? key}) : super(key: key);

  @override
  State<FullLyric> createState() => _FullLyricState();
}

class _FullLyricState extends State<FullLyric> {
  @override
  Widget build(BuildContext context) {
    final audioPlayer = context.watch<AudioPlayerNotifier>();
    return FutureBuilder(
      future: rootBundle.loadString(
          'assets/lrc/${audioPlayer.currentSong.path.split('.')[0]}.lrc'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        Lrc parsedLrc = snapshot.data.toString().toLrc();
        return ListView.builder(
            itemCount: parsedLrc.lyrics.length,
            itemBuilder: (BuildContext context, int index) {
              return lyricLine(parsedLrc.lyrics, index);
            });
      },
    );
  }

  Widget lyricLine(List<LrcLine> lrcList, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Text(
        lrcList[index].lyrics,
        style: TextStyle(
          fontSize: 16,
          fontWeight: isCurrentLyric(lrcList, index)
              ? FontWeight.bold
              : FontWeight.normal,
        ),
      ),
    );
  }

  bool isCurrentLyric(List<LrcLine> lrcList, int index) {
    Duration position = Provider.of<AudioPlayerNotifier>(context).position;
    Duration startTime = lrcList[index].timestamp;
    Duration endTime = lrcList.length == index + 1
        ? Provider.of<AudioPlayerNotifier>(context).duration
        : lrcList[index + 1].timestamp;

    if (startTime <= position && position < endTime) {
      return true;
    } else {
      return false;
    }
  }
}
