import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';

class LikedNotifier extends ChangeNotifier {
  final List<CheerSong> _likedSongList = [];

  void toggleLikedSong(CheerSong likedSong) {
    if (isLiked(likedSong)) {
      for (int i = 0; i < _likedSongList.length; i++) {
        if (_likedSongList[i] == likedSong) {
          _likedSongList.removeAt(i);
          break;
        }
      }
    } else {
      _likedSongList.add(likedSong);
    }
    notifyListeners();
  }

  bool isLiked(CheerSong cheerSong) {
    for (int i = 0; i < _likedSongList.length; i++) {
      if (_likedSongList[i] == cheerSong) {
        return true;
      }
    }
    return false;
  }

  List<CheerSong> get likedSongList => _likedSongList;
}
