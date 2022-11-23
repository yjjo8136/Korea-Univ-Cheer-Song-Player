import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class AudioPlayerNotifier extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  String _songPath = 'minjoguiAria.mp3';
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
        _isRepeat = false;
      }
      notifyListeners();
    });
  }

  playAudio(String urlPath) {
    _audioPlayer.play(AssetSource(urlPath));
  }

  pauseAudio() {
    audioPlayer.pause();
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get duration => _duration;
  Duration get position => _position;
  bool get isPlaying => _isPlaying;
  bool get isRepeat => _isRepeat;
  String get songPath => _songPath;
}
