import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../vm/home_ctrl.dart';
import 'appbar/myappbar.dart';
import 'home.dart';

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
      appBar: const MyAppBar(),
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
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const Divider(
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
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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
                keyboardType: TextInputType.multiline,
                maxLines: 15,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(
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
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.check),
              label: const Text(
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
      backgroundColor: const Color.fromARGB(255, 145, 199, 167),
      barrierDismissible: false,
      actions: [
        TextButton(
          onPressed: () {
            HomeController homeController = Get.find();
            homeController.controller.animateTo(3);
            Get.off(const Home());
          },
          child: const Text(
            'OK',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
