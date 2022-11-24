class CheerSong {
  String title;
  String artist;
  String path;

  CheerSong({required this.title, required this.artist, required this.path});
}

final List<CheerSong> songInfoList = [
  CheerSong(title: '민족의 아리아', artist: '고려대학교', path: 'minjoguiAria.mp3'),
  CheerSong(title: '뱃노래', artist: '고려대학교', path: 'baesnorae.mp3'),
  CheerSong(title: 'Forever', artist: '고려대학교', path: 'FOREVER.mp3'),
  CheerSong(title: '출사표', artist: '고려대학교', path: 'chulsapyo.mp3'),
  CheerSong(title: '고래사냥', artist: '고려대학교', path: 'goraeSanyang.mp3'),
];
