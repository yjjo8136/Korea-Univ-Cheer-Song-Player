import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';

class LikedNotifier extends ChangeNotifier {
  final List<CheerSong> _likedSongList = [];

  void toggleLikedSong(CheerSong newLikedSong) {
    if (isLiked(newLikedSong)) {
      for (int i = 0; i < _likedSongList.length; i++) {
        if (_likedSongList[i].title == newLikedSong.title &&
            _likedSongList[i].artist == newLikedSong.artist) {
          _likedSongList.removeAt(i);
          break;
        }
      }
    } else {
      _likedSongList.add(newLikedSong);
    }
    notifyListeners();
  }

  bool isLiked(CheerSong songInfo) {
    bool liked = false;
    _likedSongList.forEach((element) {
      if (element.title == songInfo.title &&
          element.artist == songInfo.artist) {
        liked = true;
      }
    });
    return liked;
  }

  List<CheerSong> get likedSongList => _likedSongList;
}
