import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/playlist_song_tile.dart';
import 'package:provider/provider.dart';

import '../notifier/audio_player_notifier.dart';

class PlaylistEditPage extends StatefulWidget {
  @override
  State<PlaylistEditPage> createState() => _PlaylistEditPageState();
}

class _PlaylistEditPageState extends State<PlaylistEditPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            _buildTitle(context),
            SizedBox(height: 15),
            _buildReorderablePlaylist(context),
          ],
        ),
      ),
    );
  }

  Widget _buildReorderablePlaylist(BuildContext context) {
    final audioPlayer = context.watch<AudioPlayerNotifier>();

    return Expanded(
      child: ReorderableListView.builder(
        key: Key("Const"),
        itemCount: audioPlayer.playlist.length,
        itemBuilder: (context, index) {
          return Container(
            key: ValueKey(audioPlayer.playlist[index].title),
            child: PlaylistSongTile(
              title: audioPlayer.playlist[index].title,
              artist: audioPlayer.playlist[index].artist,
              selected: audioPlayer.currentSong.title ==
                      audioPlayer.playlist[index].title
                  ? true
                  : false,
              editMode: true,
              editIndex: index,
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          audioPlayer.reorderPlaylist(oldIndex, newIndex);
        },
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 40, bottom: 10, right: 10),
      child: Row(
        children: [
          Text(
            '플레이리스트 편집',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF910023),
            ),
          ),
          Spacer(),
          _buildDoneButton(context),
        ],
      ),
    );
  }

  Widget _buildDoneButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        alignment: Alignment.topRight,
        child: InkWell(
          child: Text(
            "완료",
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF910023),
            ),
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
