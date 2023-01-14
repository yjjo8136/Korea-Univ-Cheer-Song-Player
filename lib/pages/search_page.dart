import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/song_tile.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 20, bottom: 20),
              child: Container(
                width: double.infinity,
                child: Text(
                  '응원가 전체 보기',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF910023)),
                ),
              ),
            ),
            /*
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(Icons.search, size: 30),
                  SizedBox(width: 20),
                  Expanded(child: TextField()),
                  SizedBox(width: 10),
                ],
              ),
            ),
            */
            Expanded(
              child: ListView.builder(
                itemCount: songInfoList.length,
                itemBuilder: (context, index) {
                  return SongTile(
                    title: songInfoList[index].title,
                    artist: songInfoList[index].artist,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
