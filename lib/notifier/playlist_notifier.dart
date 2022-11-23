import 'package:flutter/material.dart';

class PlaylistNotifier extends ChangeNotifier {
  final List<List<String>> _playlist = [];

  void addPlaylist(List<String> newSong) {
    if (InPlaylist(newSong)) {
      for (int i = 0; i < _playlist.length; i++) {
        if (_playlist[i][0] == newSong[0] && _playlist[i][1] == newSong[1]) {
          _playlist.removeAt(i);
          _playlist.add(newSong);
          break;
        }
      }
    } else {
      _playlist.add(newSong);
    }
    notifyListeners();
  }

  bool InPlaylist(List<String> songInfo) {
    bool alreadyIn = false;
    _playlist.forEach((element) {
      if (element[0] == songInfo[0] && element[1] == songInfo[1]) {
        alreadyIn = true;
      }
    });
    return alreadyIn;
  }

  List<List<String>> get playlist => _playlist;
}
