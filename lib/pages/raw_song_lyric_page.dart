import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korea_univ_cheer_song_player/components/bottom_play_bar.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:lrc/lrc.dart';
import 'package:provider/provider.dart';

class RawSongLyricPage extends StatelessWidget {
  final CheerSong song;

  const RawSongLyricPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                _buildSongTitle(),
                Spacer(),
                InkWell(
                  child: Icon(Icons.close, size: 30),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                SizedBox(width: 16),
              ],
            ),
            SizedBox(height: 20),
            _buildLyric(),
            BottomPlayBar(),
          ],
        ),
      ),
    );
  }

  Widget _buildSongTitle() {
    return Padding(
      padding: const EdgeInsets.only(left: 16),
      child: Consumer<AudioPlayerNotifier>(
        builder: (context, audioPlayer, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  song.artist,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildLyric() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: _buildRawSongWidget(),
      ),
    );
  }

  Widget _buildRawSongWidget() {
    return FutureBuilder(
      future:
          rootBundle.loadString('assets/lrc/${song.path.split('.')[0]}.lrc'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return CircularProgressIndicator();
        } else {
          Lrc parsedLrc = snapshot.data.toString().toLrc();
          return ListView.builder(
              itemCount: parsedLrc.lyrics.length,
              itemBuilder: (BuildContext context, int index) {
                return lyricLine(parsedLrc.lyrics, index);
              });
        }
      },
    );
  }

  Widget lyricLine(List<LrcLine> lrcList, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        lrcList[index].lyrics,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
