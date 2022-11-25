import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';

class AudioPlayerNotifier extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = new Duration();
  Duration _position = new Duration();
  CheerSong _currentSong =
      CheerSong(title: '민족의 아리아', artist: '고려대학교', path: 'minjoguiAria.mp3');
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
      } else if (_isRepeat == false) {
        if (true /*다음 노래가 플레이리스트에 있으면*/) {
        } else {
          _isPlaying = false;
        }
      }
      notifyListeners();
    });
  }

  playAudio(CheerSong playingSong) async {
    if (_currentSong.path != playingSong.path) {
      _currentSong = playingSong;
      _audioPlayer.pause();
      await _audioPlayer.play(AssetSource(playingSong.path));
    } else {
      await _audioPlayer.play(AssetSource(playingSong.path));
    }
    notifyListeners();
  }

  playAudioWithPath(String path) async {
    if (_currentSong.path != path) {
      late CheerSong currentSong;
      for (int i = 0; i < songInfoList.length; i++) {
        if (songInfoList[i].path == path) {
          currentSong = songInfoList[i];
          break;
        }
      }
      _currentSong = currentSong;
      _audioPlayer.pause();
      await _audioPlayer.play(AssetSource(path));
    } else {
      await _audioPlayer.play(AssetSource(path));
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

  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get duration => _duration;
  Duration get position => _position;
  bool get isPlaying => _isPlaying;
  bool get isRepeat => _isRepeat;
  CheerSong get currentSong => _currentSong;
}
