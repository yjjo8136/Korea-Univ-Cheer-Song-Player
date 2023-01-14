import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/audio_file.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';
import 'package:korea_univ_cheer_song_player/components/two_line_lyric.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/notifier/liked_notifier.dart';
import 'package:korea_univ_cheer_song_player/pages/lyric_detail_page.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:provider/provider.dart';

class SongDetailPage extends StatefulWidget {
  @override
  State<SongDetailPage> createState() => _SongDetailPageState();
}

class _SongDetailPageState extends State<SongDetailPage> {
  @override
  Widget build(BuildContext context) {
    final likedNotifier = context.watch<LikedNotifier>();
    final audioPlayer = context.watch<AudioPlayerNotifier>();
    late CheerSong currentSong;
    for (int i = 0; i < songInfoList.length; i++) {
      if (songInfoList[i].title == audioPlayer.currentSong.title) {
        currentSong = songInfoList[i];
        break;
      }
    }

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                _buildCloseButton(context),
                Text(
                  audioPlayer.currentSong.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  audioPlayer.currentSong.artist,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Icon(
                        likedNotifier.isLiked(currentSong)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 30,
                        color: Color(0xFF7C001A),
                      ),
                      onTap: () {
                        likedNotifier.toggleLikedSong(currentSong);
                      },
                    ),
                    SizedBox(width: 50),
                    MoreInfoBottomSheet(
                      title: audioPlayer.currentSong.title,
                      artist: audioPlayer.currentSong.artist,
                      size: 30,
                      showDeleteFromPlaylist: true,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: Image.asset(
                    currentSong.artist == '고려대학교'
                        ? 'assets/images/korea_univ_logo.png'
                        : 'assets/images/yonsei_univ_logo.png',
                    height: 270,
                    width: 270,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20),
                InkWell(
                  child: SizedBox(
                    width: double.infinity,
                    height: 65,
                    child: TwoLineLyric(),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LyricDetailPage(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 30),
                AudioFile(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 50,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
