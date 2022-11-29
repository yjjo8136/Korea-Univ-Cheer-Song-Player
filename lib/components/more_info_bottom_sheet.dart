import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/notifier/liked_notifier.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:provider/provider.dart';

class MoreInfoBottomSheet extends StatelessWidget {
  final String title;
  final String artist;
  final double size;
  final showDeleteFromPlaylist;

  const MoreInfoBottomSheet({
    required this.title,
    required this.artist,
    required this.size,
    this.showDeleteFromPlaylist = false,
  });

  @override
  Widget build(BuildContext context) {
    late CheerSong currentSong;

    for (int i = 0; i < songInfoList.length; i++) {
      if (songInfoList[i].title == title) {
        currentSong = songInfoList[i];
        break;
      }
    }

    return InkWell(
      child: Icon(Icons.more_vert, size: size),
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Color(0xFFD7C9B1),
          context: context,
          builder: (BuildContext context) {
            return _buildBottomSheetContext(context, currentSong);
          },
        );
      },
    );
  }

  Widget _buildBottomSheetContext(BuildContext context, CheerSong currentSong) {
    final likedNotifier = context.watch<LikedNotifier>();
    final audioNotifier = context.watch<AudioPlayerNotifier>();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    artist,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              Spacer(),
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
              SizedBox(width: 20),
              IconButton(
                icon: Icon(Icons.close, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          SizedBox(height: 30),
          InkWell(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '가사 보기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            onTap: () {},
          ),
          Divider(),
          InkWell(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '응원 동작 보기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            onTap: () {},
          ),
          Divider(),
          InkWell(
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  '재생 목록에 담기',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            onTap: () {
              audioNotifier.addToPlaylist(currentSong);
              audioNotifier.playAudio();
            },
          ),
          Divider(),
          showDeleteFromPlaylist
              ? InkWell(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Text(
                        '재생목록에서 삭제',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                  onTap: () {
                    audioNotifier.deleteFromPlaylist(currentSong);
                  },
                )
              : SizedBox(height: 0),
        ],
      ),
    );
  }
}
