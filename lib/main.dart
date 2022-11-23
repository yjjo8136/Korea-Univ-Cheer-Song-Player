import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/notifier/audio_player_notifier.dart';
import 'package:korea_univ_cheer_song_player/notifier/liked_notifier.dart';
import 'package:korea_univ_cheer_song_player/notifier/playlist_notifier.dart';
import 'package:korea_univ_cheer_song_player/pages/navigation_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LikedNotifier>(
          create: (context) => LikedNotifier(),
        ),
        ChangeNotifierProvider<PlaylistNotifier>(
          create: (context) => PlaylistNotifier(),
        ),
        ChangeNotifierProvider<AudioPlayerNotifier>(
          create: (context) => AudioPlayerNotifier(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFD7C9B1)),
        home: NavigationPage(),
      ),
    );
  }
}
