

import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
  DocumentReference ref;
  String title;
  String content;
  String date; // date를 DateTime 타입으로 변경
  // String avata;

  Board({
    required this.ref,
    required this.title,
    required this.content,
    required this.date,
    // required this.avata,
  });

  
  factory Board.fromJson(Map<String, dynamic> data) {
    return Board(
      ref: data['ref'],
      title: data['title'],
      content: data['content'],
      date: data['date'], // String 형태의 날짜를 그대로 저장
      // avata: data['avata'],
    );
  }
}