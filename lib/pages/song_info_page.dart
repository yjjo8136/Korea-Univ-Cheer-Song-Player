import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SongInfoPage extends StatelessWidget {
  final CheerSong song;

  const SongInfoPage({super.key, required this.song});

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
            _buildSongInfo(context),
            _buildVideoLinkButton(),
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

  Widget _buildSongInfo(BuildContext context) {
    return FutureBuilder(
        future: rootBundle
            .loadString('assets/song_infos/${song.path.split(".")[0]}.txt'),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          } else if (snapshot.data == null) {
            return Center(
              child: Text(
                "등록된 곡 상세정보가 없습니다",
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            String songInfoText = snapshot.data.toString();
            return Expanded(
              child: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: Text(songInfoText),
                ),
              ),
            );
          }
        });
  }

  Widget _buildVideoLinkButton() {
    String url = songInfoUrl[song.title] ?? "Error";
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF910023),
      ),
      onPressed: () async {
        try {
          await launchUrlString(url,
              mode: LaunchMode.externalNonBrowserApplication);
        } catch (e) {
          print("App connection Failed!");
          try {
            await launchUrlString(url);
          } catch (e) {
            print("Web connection Failed!");
          }
        }
      },
      child: Wrap(
        children: [
          Icon(Icons.play_arrow_rounded),
          Text("YouTube 영상"),
        ],
      ),
    );
  }
}
