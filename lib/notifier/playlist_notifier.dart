import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PlaylistNotifier extends ChangeNotifier {
  List<CheerSong> _playlist = [];
  SharedPreferences? prefs;

  PlaylistNotifier() {
    _loadFromPrefs();
  }

  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    final String? playlistString = prefs!.getString('playlist');
    if (playlistString != null) {
      _playlist = CheerSong.decode(playlistString);
    }
  }

  _saveToPrefs() async {
    await _initPrefs();
    final String encodedData = CheerSong.encode(_playlist);
    prefs!.setString('playlist', encodedData);
  }

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
    _saveToPrefs();
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
