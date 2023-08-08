import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:season3_team1_mainproject/view/community.dart';

class BoardInsert extends StatefulWidget {
  const BoardInsert({Key? key}) : super(key: key);

  @override
  State<BoardInsert> createState() => _BoardInsertState();
}

class _BoardInsertState extends State<BoardInsert> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: 400,
              decoration: const BoxDecoration(
                // color: Color.fromARGB(255, 186, 198, 241),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: const Center(
                child: Text(
                  '커뮤니티',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(
              thickness: 1.0,
            ),
            const SizedBox(
              height: 10,
            ),
            const Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
                  child: Text(
                    ' 원하는 내용을 \n 작성해주세요',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 25, 0, 0),
                  child: Icon(
                    Icons.sentiment_satisfied,
                    size: 27,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: '글의 제목을 입력하세요',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  hintText: '글의 내용을 입력하세요',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15.0),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(),
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
                keyboardType: TextInputType.text,
                maxLines: 15,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                // 현재 시간 얻기
                DateTime now = DateTime.now();

                // 원하는 날짜 형식으로 변환
                String formattedDate = DateFormat('yyyy-MM-dd').format(now);

                // Firestore에 저장
                FirebaseFirestore.instance.collection('community').add({
                  'title': titleController.text,
                  'content': contentController.text,
                  'date': formattedDate, // 현재 시간 문자열 저장
                });
                _showDialog(context);
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: Icon(Icons.check),
              label: Text(
                '게시',
                style: TextStyle(fontSize: 20),
              ),
            )
          ],
        ),
      ),
    );
  }

  //Function----------------
  _showDialog(BuildContext context) {
    Get.defaultDialog(
        title: '입력 결과',
        middleText: '입력이 완료 되었습니다.',
        backgroundColor:  Color.fromARGB(255, 145, 199, 167),
        barrierDismissible: false,
        actions: [
          TextButton(
              onPressed: () {
                Get.to(Community());
              },
              child: Text('OK'))
        ]);

    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     // 다이얼로그 띄우기
    //     return AlertDialog(
    //       title: const Text("입력 결과"),
    //       content: const Text("입력이 완료 되었습니다."),
    //       actions: [
    //         ElevatedButton(
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             Navigator.pop(context); // Main화면으로 이동
    //           },
    //           child: Center(child: const Text('OK')),
    //         ),
    //       ],
    //     );
    //   },
    // );
  }
}
