import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/song_tile.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';

class SearchPage extends StatefulWidget {
  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final controller = TextEditingController();
  List<CheerSong> songs = songInfoList;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40, top: 20),
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
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: SizedBox(
                height: 60,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Icon(Icons.search, size: 30, color: Color(0xFF910023)),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: controller,
                        style: TextStyle(color: Color(0xFF910023)),
                        cursorColor: Color(0xFF910023),
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0x4D910023)),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF910023)),
                          ),
                          suffix: IconButton(
                            icon: Icon(
                              Icons.clear,
                              color: Color(0xFF910023),
                            ),
                            onPressed: () {
                              if (controller.value == TextEditingValue.empty) {
                                // 올라온 키보드 끄기
                                FocusManager.instance.primaryFocus?.unfocus();
                              }
                              controller.value = TextEditingValue.empty;
                              songs = songInfoList;
                              setState(() {});
                            },
                          ),
                        ),
                        onChanged: searchSong,
                      ),
                    ),
                    SizedBox(width: 20),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return SongTile(
                    title: songs[index].title,
                    artist: songs[index].artist,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void searchSong(String query) {
    final suggestions = songInfoList.where((song) {
      final songTitle = song.title.toLowerCase();
      final input = query.toLowerCase();

      return songTitle.contains(input);
    }).toList();

    setState(() {
      songs = suggestions;
    });
  }
}
