import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/audio_file.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';
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
        body: Center(
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
              SizedBox(height: 30),
              Image.asset(
                'assets/korea_univ_logo.png',
                height: 270,
                width: 270,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              InkWell(
                child: Column(
                  children: [
                    Text(
                      '자 지축을 박차고 자 포효하라 그대',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '조국의 영원한 고동이 되리라',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0x80000000),
                      ),
                    ),
                  ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Icon(
                        likedNotifier.isLiked(currentSong)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 30),
                    onTap: () {
                      likedNotifier.toggleLikedSong(currentSong);
                    },
                  ),
                  SizedBox(width: 50),
                  MoreInfoBottomSheet(
                    title: audioPlayer.currentSong.title,
                    artist: audioPlayer.currentSong.artist,
                    size: 50,
                  ),
                ],
              ),
              SizedBox(height: 10),
              AudioFile(),
            ],
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
