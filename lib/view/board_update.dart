import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import 'package:season3_team1_mainproject/view/community.dart';

import '../model/board_model.dart';

class BoardUpdate extends StatefulWidget {
  const BoardUpdate({super.key});

  @override
  State<BoardUpdate> createState() => _BoardUpdateState();
}

class _BoardUpdateState extends State<BoardUpdate> {
  late TextEditingController titleController;
  late TextEditingController contentController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(); 
    contentController = TextEditingController(); 
    var board = Get.arguments as Board?; 
    if (board != null) {
      titleController.text = board.title;
      contentController.text = board.content;
    }
  }

  @override
  Widget build(BuildContext context) {
    var board = Get.arguments ?? "_";
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: 400,
              decoration: const BoxDecoration(
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
                style: const TextStyle(
                  fontSize: 17,
                ),
                maxLines: 15,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              onPressed: () {
                if (board != null) {
                  board?.ref.update({
                    'title': titleController.text,
                    'content': contentController.text
                  }).then((_) {
                    _showDialog(context);
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              icon: const Icon(Icons.edit_outlined),
              label: const Text(
                '수정',
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
        title: '수정 결과',
        middleText: '수정이 완료 되었습니다.',
        backgroundColor: const Color.fromARGB(255, 180, 245, 207),
        barrierDismissible: false,
        actions: [
          TextButton(
              onPressed: () {
                Get.to(const Community());
              },
              child: const Text('OK',style: TextStyle(fontWeight: FontWeight.bold),)),
        ]);
  }
}
