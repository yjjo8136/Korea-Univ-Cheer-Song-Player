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
            return ListView.builder(
                itemCount: parsedLrc.lyrics.length,
                itemBuilder: (BuildContext context, int index) {
                  return lyricLine(parsedLrc.lyrics, index);
                });
          }
        });
  }

  Widget lyricLine(List<LrcLine> lrcList, int index) {
    return Consumer<AudioPlayerNotifier>(
      builder: (context, audioPlayer, child) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: InkWell(
            child: Text(
              lrcList[index].lyrics,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isCurrentLyric(lrcList, index)
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            onTap: () {
              audioPlayer.setPosition(lrcList[index].timestamp);
            },
          ),
        );
      },
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
