import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/pages/navigation_page.dart';
import 'package:korea_univ_cheer_song_player/saved_notifier.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SavedNotifier>(
      create: (context) => SavedNotifier(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(scaffoldBackgroundColor: const Color(0xFFD7C9B1)),
        home: NavigationPage(),
      ),
    );
  }
}
