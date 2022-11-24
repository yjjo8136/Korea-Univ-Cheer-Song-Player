import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerNotifier extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  String _songPath = 'minjoguiAria.mp3';
  String _title = '민족의 아리아';
  String _artist = '고려대학교';
  bool _isPlaying = false;
  bool _isRepeat = false;

  AudioPlayerNotifier() {
    initAudio();
  }

  initAudio() {
    _audioPlayer.onDurationChanged.listen((updatedDuration) {
      _duration = updatedDuration;
      notifyListeners();
    });

    _audioPlayer.onPositionChanged.listen((updatedPosition) {
      _position = updatedPosition;
      notifyListeners();
    });

    _audioPlayer.onPlayerStateChanged.listen((playerState) {
      if (playerState == PlayerState.playing) {
        _isPlaying = true;
      }
      if (playerState == PlayerState.paused) {
        _isPlaying = false;
      }
      notifyListeners();
    });

    _audioPlayer.onPlayerComplete.listen((event) {
      _position = Duration(seconds: 0);
      if (_isRepeat == true) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      notifyListeners();
    });
  }

  playAudio(String urlPath) async {
    if (_songPath != urlPath) {
      _songPath = urlPath;
      _audioPlayer.pause();
      await _audioPlayer.play(AssetSource(urlPath));
    } else {
      await _audioPlayer.play(AssetSource(urlPath));
    }
    notifyListeners();
  }

  pauseAudio() {
    _audioPlayer.pause();
    notifyListeners();
  }

  toggleRepeatAudio() {
    if (_isRepeat == false) {
      _isRepeat = true;
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
    } else if (_isRepeat == true) {
      _isRepeat = false;
      _audioPlayer.setReleaseMode(ReleaseMode.release);
    }
    notifyListeners();
  }

  setTitleAndArtist(String title, String artist) {
    _title = title;
    _artist = artist;
    notifyListeners();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get duration => _duration;
  Duration get position => _position;
  bool get isPlaying => _isPlaying;
  bool get isRepeat => _isRepeat;
  String get songPath => _songPath;
  String get title => _title;
  String get artist => _artist;
}
