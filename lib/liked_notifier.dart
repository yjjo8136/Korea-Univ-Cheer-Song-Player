import 'package:flutter/material.dart';

class LikedNotifier extends ChangeNotifier {
  final List<List<String>> _likedSongList = [];

  void toggleLikedSong(List<String> newLikedSong) {
    if (isLiked(newLikedSong)) {
      for (int i = 0; i < _likedSongList.length; i++) {
        if (_likedSongList[i][0] == newLikedSong[0] &&
            _likedSongList[i][1] == newLikedSong[1]) {
          _likedSongList.removeAt(i);
          break;
        }
      }
    } else {
      _likedSongList.add(newLikedSong);
    }
    notifyListeners();
  }

  bool isLiked(List<String> songInfo) {
    bool liked = false;
    _likedSongList.forEach((element) {
      if (element[0] == songInfo[0] && element[1] == songInfo[1]) {
        liked = true;
      }
    });
    return liked;
  }

  List<List<String>> get likedSongList => _likedSongList;
}
