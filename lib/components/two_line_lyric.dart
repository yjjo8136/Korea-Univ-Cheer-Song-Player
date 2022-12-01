import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:lrc/lrc.dart';
import 'package:provider/provider.dart';

class TwoLineLyric extends StatefulWidget {
  const TwoLineLyric({Key? key}) : super(key: key);

  @override
  State<TwoLineLyric> createState() => _TwoLineLyricState();
}

class _TwoLineLyricState extends State<TwoLineLyric> {
  @override
  Widget build(BuildContext context) {
    final audioPlayer = context.watch<AudioPlayerNotifier>();
    return FutureBuilder(
        future: rootBundle.loadString(
            'assets/lrc/${audioPlayer.currentSong.path.split('.')[0]}.lrc'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          } else if (!snapshot.data.toString().isValidLrc) {
            return Center(
              child: Text(
                "등록된 가사가 없습니다",
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            Lrc parsedLrc = snapshot.data.toString().toLrc();
            int index = 0;
            for (int i = 0; i < parsedLrc.lyrics.length; i++) {
              if (isCurrentLyric(parsedLrc.lyrics, i)) {
                index = i;
              }
            }
            return Column(
              children: [
                lyricLine(parsedLrc.lyrics, index),
                SizedBox(height: 4),
                lyricLine(parsedLrc.lyrics, index + 1),
              ],
            );
          }
        });
  }

  Widget lyricLine(List<LrcLine> lrcList, int index) {
    if (index == lrcList.length) {
      return Text('');
    }
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Text(
          lrcList[index].lyrics,
          style: TextStyle(
            fontSize: 18,
            fontWeight: isCurrentLyric(lrcList, index)
                ? FontWeight.bold
                : FontWeight.normal,
            color: isCurrentLyric(lrcList, index)
                ? Color(0xFF7C001A)
                : Colors.black,
          ),
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
