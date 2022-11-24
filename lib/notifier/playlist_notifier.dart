import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';

class PlaylistNotifier extends ChangeNotifier {
  final List<CheerSong> _playlist = [];

  void addPlaylist(CheerSong newSong) {
    if (InPlaylist(newSong)) {
      for (int i = 0; i < _playlist.length; i++) {
        if (_playlist[i].title == newSong.title &&
            _playlist[i].artist == newSong.artist) {
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

  void deletePlaylist(CheerSong deleteSong) {
    if (InPlaylist(deleteSong)) {
      for (int i = 0; i < _playlist.length; i++) {
        if (_playlist[i].title == deleteSong.title &&
            _playlist[i].artist == deleteSong.artist) {
          _playlist.removeAt(i);
          break;
        }
      }
    } else {}
    notifyListeners();
  }

  bool InPlaylist(CheerSong songInfo) {
    bool alreadyIn = false;
    _playlist.forEach((element) {
      if (element.title == songInfo.title &&
          element.artist == songInfo.artist) {
        alreadyIn = true;
      }
    });
    return alreadyIn;
  }

  List<CheerSong> get playlist => _playlist;
}
