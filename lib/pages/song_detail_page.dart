import 'package:flutter/material.dart';
import 'package:korea_univ_cheer_song_player/components/more_info_bottom_sheet.dart';
import 'package:korea_univ_cheer_song_player/pages/lyric_detail_page.dart';

class SongDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              _buildCloseButton(context),
              Text(
                '민족의 아리아',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '고려대학교',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 30),
              Image.asset(
                'assets/korea_univ_logo.png',
                height: 270,
                width: 270,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 20),
              InkWell(
                child: Column(
                  children: [
                    Text(
                      '자 지축을 박차고 자 포효하라 그대',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      '조국의 영원한 고동이 되리라',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0x80000000),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LyricDetailPage(),
                    ),
                  );
                },
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 50),
                  SizedBox(width: 50),
                  MoreInfoBottomSheet(size: 50),
                ],
              ),
              SizedBox(height: 25),
              Container(width: 320, height: 5, color: Colors.grey),
              SizedBox(height: 5),
              Row(
                children: [
                  SizedBox(width: 20),
                  Text(
                    '00:48',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF7C001A),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '02:22',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0x80000000),
                    ),
                  ),
                  SizedBox(width: 20),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Icon(Icons.repeat, size: 40),
                  Spacer(),
                  Icon(Icons.skip_previous, size: 40),
                  Spacer(),
                  Icon(Icons.play_arrow, size: 60),
                  Spacer(),
                  Icon(Icons.skip_next, size: 40),
                  Spacer(),
                  Icon(Icons.shuffle, size: 40),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0),
      child: Container(
        alignment: Alignment.topRight,
        child: IconButton(
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 50,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
