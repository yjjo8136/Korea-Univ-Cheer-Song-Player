import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/notifier/liked_notifier.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final likedSongList = context.watch<LikedNotifier>().likedSongList;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
              child: Container(
                width: double.infinity,
                child: Text(
                  '2022 고연전 빈출 응원가',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSongTile('1', '민족의 아리아', '고려대학교'),
                  _buildSongTile('2', '뱃노래', '고려대학교'),
                  _buildSongTile('3', 'Forever', '고려대학교'),
                  _buildSongTile('4', '출사표', '고려대학교'),
                  _buildSongTile('5', '들보기', '고려대학교'),
                  _buildSongTile('6', '엘리제를 위하여', '고려대학교'),
                  _buildSongTile('7', '꿇어라 연세', '고려대학교'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSongTile(String rank, String title, String artist) {
    late CheerSong currentSong;
    for (int i = 0; i < songInfoList.length; i++) {
      if (songInfoList[i].title == title) {
        currentSong = songInfoList[i];
        break;
      }
    }
    return Consumer<AudioPlayerNotifier>(
      builder: (context, audioPlayerNotifier, child) {
        return Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Color(0xFFDBBA81),
            ),
            width: double.infinity,
            height: 80,
            child: Row(
              children: [
                SizedBox(width: 25),
                Image.asset(
                    currentSong.artist == '고려대학교'
                        ? 'assets/images/korea_univ_logo.png'
                        : 'assets/images/yonsei_univ_logo.png',
                    height: 45,
                    width: 45),
                SizedBox(width: 10),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rank + '    ' + title,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        '          ' + artist,
                        style: TextStyle(
                          color: Color(0x4D000000),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                InkWell(
                  child: Icon(Icons.play_arrow, size: 30),
                  onTap: () {
                    audioPlayerNotifier.addToPlaylist(currentSong);
                    audioPlayerNotifier.playAudio();
                  },
                ),
                MoreInfoBottomSheet(title: title, artist: artist, size: 30),
                SizedBox(width: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
