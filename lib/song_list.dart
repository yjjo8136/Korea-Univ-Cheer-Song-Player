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
  CheerSong(title: 'KOREA', artist: '고려대학교', path: 'KOREA.mp3'),
  CheerSong(title: '캉캉', artist: '고려대학교', path: 'KangKang.mp3'),
  CheerSong(title: '무인도', artist: '고려대학교', path: 'muindo.mp3'),
  CheerSong(title: '샹젤리제', artist: '고려대학교', path: 'changelige.mp3'),
  CheerSong(title: '쉬잇', artist: '고려대학교', path: 'sheet.mp3'),
  CheerSong(title: '연세까스', artist: '고려대학교', path: 'yonseigas.mp3'),
  CheerSong(title: '교가', artist: '고려대학교', path: 'gyoga.mp3'),
  CheerSong(title: '연세여 사랑한다', artist: '연세대학교', path: 'loveYonsei.mp3'),
  CheerSong(title: '하늘끝까지', artist: '연세대학교', path: 'haneulgutt.mp3'),
  CheerSong(title: '원시림', artist: '연세대학교', path: 'wonsilim.mp3'),
  CheerSong(title: '서시', artist: '연세대학교', path: 'seosi.mp3'),
  CheerSong(title: '오늘밤새', artist: '연세대학교', path: 'bamse.mp3'),
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

class AudioMetadata {
  final String title;
  final String artist;
  final String path;

  AudioMetadata({
    required this.title,
    required this.artist,
    required this.path,
  });
}

final Map<String, String> songInfoUrl = {
  '민족의 아리아': "https://youtu.be/iCCFKh5g7vc?t=130",
  '뱃노래': "https://www.youtube.com/watch?v=dDIfsTNvLn4",
  'Forever': "https://www.youtube.com/watch?v=42QRrVnTVVY",
  '출사표': "https://www.youtube.com/watch?v=kz6cZsMOqLQ",
  '고래사냥': "https://www.youtube.com/watch?v=SN0ji6cGPUo",
  '붉은노을': "https://www.youtube.com/watch?v=Whzb6gu1V6s&t=418s",
  '청춘예찬': "https://www.youtube.com/watch?v=jB3r7Vaye7A",
  '들보기': "https://www.youtube.com/watch?v=pt68UVX42Bk",
  '엘리제를 위하여': "https://www.youtube.com/watch?v=X_LwruHrR_I&t=27s",
  'Go 100': "https://www.youtube.com/watch?v=2lC1nYsP0kY",
  '고대를 노래하라': "https://www.youtube.com/watch?v=tzbCUEoqwN8",
  '고대를 사랑하라': "https://www.youtube.com/watch?v=sjUQRJJtvF8",
  '하늘이여': "https://www.youtube.com/watch?v=kz6cZsMOqLQ&t=77s",
  '호들갑': "https://www.youtube.com/watch?v=vZd4yMGejCE",
  '호랑이': "https://www.youtube.com/watch?v=WLwifYE-jYY",
  '화려, 피어난 함성': "https://www.youtube.com/watch?v=FPlrQ1WoQko",
  'IPSELENTI': "https://www.youtube.com/watch?v=GwbXMqr4KUQ",
  '지야의 함성': "https://www.youtube.com/watch?v=cSe9Uhshmvw",
  '꿇어라 연세': "https://www.youtube.com/watch?v=4-nXQHePLzc",
  '너 그리고 나': "https://www.youtube.com/watch?v=1A80izFULqY",
  '석탑': "https://www.youtube.com/watch?v=hDUhqVVElh0",
  '싱글벙글': "https://www.youtube.com/watch?v=2lC1nYsP0kY",
  '쎄쎄쎄': "https://www.youtube.com/watch?v=V6A_O5eOJZc",
  '우리는 고대': "https://www.youtube.com/watch?v=GwbXMqr4KUQ",
  'Yeah Yeah Yeah': "https://www.youtube.com/watch?v=Vsw0NpxXpdY",
  '영원하라': "https://www.youtube.com/watch?v=EhgZZKHFq3M",
  '연세치킨': "https://www.youtube.com/watch?v=PeiY9iaPSQk",
  'Young Tigers': "https://www.youtube.com/watch?v=2JsV7vPhzII",
  'KOREA': "https://www.youtube.com/watch?v=CACgVFcSRm8",
  '캉캉': "https://www.youtube.com/watch?v=o6T_AKIXagk",
  '무인도': "https://www.youtube.com/watch?v=c8L5FgRyB0o",
  '샹젤리제': "https://www.youtube.com/watch?v=HqTxg0K6Uus",
  '쉬잇': "https://www.youtube.com/watch?v=2yT0xEsXhQA",
  '연세까스': "https://www.youtube.com/watch?v=tsolpYfnD7w",
  '교가': "https://www.youtube.com/watch?v=K9iW5lhCDrQ",
  '연세여 사랑한다': "https://www.youtube.com/watch?v=DqmdzeLvnYo",
  '하늘끝까지': "https://www.youtube.com/watch?v=19sXqY9LGpE",
  '원시림': "https://www.youtube.com/watch?v=XIgEiPShYI8",
  '서시': "https://www.youtube.com/watch?v=6eTJOrRz2GU",
  '오늘밤새': "https://www.youtube.com/watch?v=fir18CUnv7g&t=35s",
};
