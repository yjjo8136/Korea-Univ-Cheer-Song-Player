import 'package:flutter/material.dart';

class SongTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          SizedBox(width: 25),
          Image.asset('assets/korea_univ_logo.png', height: 45, width: 45),
          SizedBox(width: 10),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '민족의 아리아',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '고려대학교',
                  style: TextStyle(
                    color: Color(0x4D000000),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Spacer(),
          Icon(Icons.play_arrow, size: 45),
          Icon(Icons.more_vert, size: 45),
          SizedBox(width: 10),
        ],
      ),
    );
  }
}
