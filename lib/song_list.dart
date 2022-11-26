import 'dart:convert';

final List<CheerSong> songInfoList = [
  CheerSong(title: '민족의 아리아', artist: '고려대학교', path: 'minjoguiAria.mp3'),
  CheerSong(title: '뱃노래', artist: '고려대학교', path: 'baesnorae.mp3'),
  CheerSong(title: 'Forever', artist: '고려대학교', path: 'FOREVER.mp3'),
  CheerSong(title: '출사표', artist: '고려대학교', path: 'chulsapyo.mp3'),
  CheerSong(title: '고래사냥', artist: '고려대학교', path: 'goraeSanyang.mp3'),
  CheerSong(title: '붉은노을', artist: '고려대학교', path: 'bulkennoeul.mp3'),
  CheerSong(title: '청춘예찬', artist: '고려대학교', path: 'cheongchunyechan.mp3'),
  CheerSong(title: '들보기', artist: '고려대학교', path: 'deulbogi.mp3'),
  CheerSong(title: '엘리제를 위하여', artist: '고려대학교', path: 'ellijereul_wihayeo.mp3'),
  CheerSong(title: 'Go 100', artist: '고려대학교', path: 'Go100.mp3'),
  CheerSong(title: '고대를 노래하라', artist: '고려대학교', path: 'godaereul_norehara.mp3'),
  CheerSong(
      title: '고대를 사랑하라', artist: '고려대학교', path: 'godaereul_saranghara.mp3'),
  CheerSong(title: '하늘이여', artist: '고려대학교', path: 'haneuriyeo.mp3'),
  CheerSong(title: '호들갑', artist: '고려대학교', path: 'hodeulgap.mp3'),
  CheerSong(title: '호랑이', artist: '고려대학교', path: 'horangi.mp3'),
  CheerSong(
      title: '화려, 피어난 함성',
      artist: '고려대학교',
      path: 'hwaryeo_pieonanhamseong.mp3'),
  CheerSong(title: 'IPSELENTI', artist: '고려대학교', path: 'IPSELENTI.mp3'),
  CheerSong(title: '지야의 함성', artist: '고려대학교', path: 'jiyaui_hamseong.mp3'),
  CheerSong(title: '꿇어라 연세', artist: '고려대학교', path: 'kkulheora_yonsei.mp3'),
  CheerSong(title: '너 그리고 나', artist: '고려대학교', path: 'neo_geurigo_na.mp3'),
  CheerSong(title: '석탑', artist: '고려대학교', path: 'seoktap.mp3'),
  CheerSong(title: '싱글벙글', artist: '고려대학교', path: 'singgeulbeonggeul.mp3'),
  CheerSong(title: '쎄쎄쎄', artist: '고려대학교', path: 'ssessesse.mp3'),
  CheerSong(title: '우리는 고대', artist: '고려대학교', path: 'urineun_godae.mp3'),
  CheerSong(title: 'Yeah Yeah Yeah', artist: '고려대학교', path: 'YeahYeahYeah.mp3'),
  CheerSong(title: '영원하라', artist: '고려대학교', path: 'yeongwonhara.mp3'),
  CheerSong(title: '연세치킨', artist: '고려대학교', path: 'yonsei_chicken.mp3'),
  CheerSong(title: 'Young Tigers', artist: '고려대학교', path: 'young_tigers.mp3'),
];

class CheerSong {
  String title;
  String artist;
  String path;

  CheerSong({
    required this.title,
    required this.artist,
    required this.path,
  });

  factory CheerSong.fromJson(Map<String, dynamic> jsonData) {
    for (int i = 0; i < songInfoList.length; i++) {
      if (songInfoList[i].title == jsonData['title']) {
        return songInfoList[i];
      }
    }
    return CheerSong(
      title: jsonData['title'],
      artist: jsonData['artist'],
      path: jsonData['path'],
    );
  }

  static Map<String, dynamic> toMap(CheerSong cheersong) => {
        'title': cheersong.title,
        'artist': cheersong.artist,
        'path': cheersong.path,
      };

  static String encode(List<CheerSong> musics) => json.encode(
        musics
            .map<Map<String, dynamic>>((music) => CheerSong.toMap(music))
            .toList(),
      );

  static List<CheerSong> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CheerSong>((item) => CheerSong.fromJson(item))
          .toList();
}
