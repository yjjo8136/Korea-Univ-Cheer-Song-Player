import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korea_univ_cheer_song_player/components/bottom_play_bar.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:lrc/lrc.dart';

class RawSongLyricPage extends StatelessWidget {
  final CheerSong song;

  const RawSongLyricPage({super.key, required this.song});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 40),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: _buildSongTitle(),
                ),
                Positioned(
                  top: -15,
                  right: 15,
                  child: _buildCloseButton(context),
                ),
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          song.artist == '고려대학교'
              ? 'assets/images/korea_univ_logo.png'
              : 'assets/images/yonsei_univ_logo.png',
          height: 35,
          width: 35,
          fit: BoxFit.fill,
        ),
        SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              song.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 3),
            Text(
              song.artist,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(
          Icons.close,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
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
