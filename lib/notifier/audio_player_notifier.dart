import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:korea_univ_cheer_song_player/song_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AudioPlayerNotifier extends ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  Duration _duration = Duration();
  Duration _position = Duration();
  CheerSong _currentSong =
      CheerSong(title: '민족의 아리아', artist: '고려대학교', path: 'minjoguiAria.mp3');
  bool _isPlaying = false;
  bool _isRepeat = false;
  List<CheerSong> _playlist = [];
  var audioPlayerPlaylist = ConcatenatingAudioSource(
    useLazyPreparation: true,
    shuffleOrder: DefaultShuffleOrder(),
    children: [],
  );
  SharedPreferences? prefs;

  AudioPlayerNotifier() {
    _loadFromPrefs();
    initAudio();
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
    for (int i = 0; i < _playlist.length; i++) {
      audioPlayerPlaylist.add(AudioSource.uri(
          Uri.parse('asset:///assets/' + _playlist[i].path),
          tag: _playlist[i]));
    }
  }

  _saveToPrefs() async {
    await _initPrefs();
    final String encodedData = CheerSong.encode(_playlist);
    prefs!.setString('playlist', encodedData);
  }

  initAudio() {
    _audioPlayer.setAudioSource(audioPlayerPlaylist,
        initialIndex: 0, initialPosition: Duration.zero);

    _audioPlayer.processingStateStream.listen((state) async {
      if (state == ProcessingState.completed) {
        await _audioPlayer.pause();
        await _audioPlayer.seek(Duration.zero, index: 0);
      }
    });

    _audioPlayer.playerStateStream.listen((playerState) {
      if (playerState.playing) {
        _isPlaying = true;
      } else {
        _isPlaying = false;
      }
      notifyListeners();
    });

    _audioPlayer.playbackEventStream.listen((event) {
      final int index = _audioPlayer.currentIndex ?? 0;
      _currentSong = _audioPlayer.audioSource?.sequence[index].tag;
      notifyListeners();
    });

    _audioPlayer.durationStream.listen((d) {
      if (d != null) {
        _duration = d;
        notifyListeners();
      }
    });

    _audioPlayer.positionStream.listen((p) {
      _position = p;
      notifyListeners();
    });
  }

  playAudio() async {
    await _audioPlayer.play();
  }

  pauseAudio() async {
    await _audioPlayer.pause();
  }

  skipToNext() async {
    await _audioPlayer.seekToNext();
  }

  skipToPrevious() async {
    await _audioPlayer.seekToPrevious();
  }

  toggleLoopMode() async {
    if (_isRepeat) {
      await _audioPlayer.setLoopMode(LoopMode.off);
    } else {
      await _audioPlayer.setLoopMode(LoopMode.one);
    }
    _isRepeat = !_isRepeat;
    notifyListeners();
  }

  addToPlaylist(CheerSong song) async {
    if (_playlist.contains(song)) {
      for (int i = 0; i < _playlist.length; i++) {
        if (_playlist[i] == song) {
          _playlist.removeAt(i);
          audioPlayerPlaylist.removeAt(i);
        }
      }
    }
    _playlist.add(song);
    await audioPlayerPlaylist.add(AudioSource.uri(
      Uri.parse('asset:///assets/' + song.path),
      tag: song,
    ));
    _currentSong = song;
    _saveToPrefs();
    await _audioPlayer.seek(Duration.zero, index: _playlist.length - 1);
  }

  deleteFromPlaylist(CheerSong song) async {
    for (int i = 0; i < _playlist.length; i++) {
      if (_playlist[i] == song) {
        _playlist.removeAt(i);
        audioPlayerPlaylist.removeAt(i);
      }
    }
    _saveToPrefs();
  }

  changePlaylistIndex(CheerSong song) {
    for (int i = 0; i < _audioPlayer.audioSource!.sequence.length; i++) {
      if (_audioPlayer.audioSource!.sequence[i].tag == song) {
        _audioPlayer.seek(Duration.zero, index: i);
        break;
      }
    }
  }

  AudioPlayer get audioPlayer => _audioPlayer;
  Duration get duration => _duration;
  Duration get position => _position;
  bool get isPlaying => _isPlaying;
  bool get isRepeat => _isRepeat;
  CheerSong get currentSong => _currentSong;
  List<CheerSong> get playlist => _playlist;
}
