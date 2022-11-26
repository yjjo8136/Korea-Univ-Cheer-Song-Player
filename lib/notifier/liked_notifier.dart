import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LikedNotifier extends ChangeNotifier {
  List<CheerSong> _likedSongList = [];
  SharedPreferences? prefs;

  LikedNotifier() {
    _loadFromPrefs();
    print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
  }

  _initPrefs() async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
  }

  _loadFromPrefs() async {
    await _initPrefs();
    final String? likedSongString = prefs!.getString('likedList');
    if (likedSongString != null) {
      _likedSongList = CheerSong.decode(likedSongString);
    }
  }

  _saveToPrefs() async {
    await _initPrefs();
    final String encodedData = CheerSong.encode(_likedSongList);
    prefs!.setString('likedList', encodedData);
  }

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
    _saveToPrefs();
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
