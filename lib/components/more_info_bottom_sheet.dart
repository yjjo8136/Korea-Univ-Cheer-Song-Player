import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/liked_notifier.dart';
import 'package:provider/provider.dart';

class MoreInfoBottomSheet extends StatelessWidget {
  final String title;
  final String artist;
  final double size;

  const MoreInfoBottomSheet(
      {required this.title, required this.artist, required this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Icon(Icons.more_vert, size: size),
      onTap: () {
        showModalBottomSheet(
          backgroundColor: Color(0xFFD7C9B1),
          context: context,
          builder: (BuildContext context) {
            return _buildBottomSheetContext(context);
          },
        );
      },
    );
  }

  Widget _buildBottomSheetContext(BuildContext context) {
    final savedNotifier = context.watch<LikedNotifier>();

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
                    savedNotifier.isLiked([title, artist])
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 30),
                onTap: () {
                  savedNotifier.toggleLikedSong([title, artist]);
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
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
