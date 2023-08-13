import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/board_model.dart';
import 'board_detail.dart';
import 'board_insert.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  State<Community> createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  late TextEditingController _searchController;
  String _searchKeyword = '';
  List<Board> allCommunities = [];

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 50,
            width: 400,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: const Center(
              child: Text(
                '공지사항',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchKeyword = value;
                });
              },
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(), // color값 생략
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(), // color값 생략
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  ),
                ),
                hintText: '검색',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          const Divider(thickness: 1.0),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('community')
                .orderBy('date', descending: false)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              }
              final documents = snapshot.data!.docs;

              allCommunities = documents
                  .map((doc) => Board(
                        ref: doc.reference,
                        title: doc['title'],
                        content: doc['content'],
                        date: doc['date'],
                        // avata: doc['avata'],
                      ))
                  .toList();

              // 검색 키워드가 있으면 해당 키워드를 포함하는 항목들만 필터링
              if (_searchKeyword.isNotEmpty) {
                allCommunities = allCommunities
                    .where((board) => board.title
                        .toLowerCase()
                        .contains(_searchKeyword.toLowerCase()))
                    .toList();
              }

              return Expanded(
                child: ListView(
                  children: allCommunities
                      .map((board) => _buildItemWidget(board))
                      .toList(),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
       checkSharedPreferences();
          // Get.to(const BoardInsert());
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(55, 55),
          shape: CircleBorder(),
        ),
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      bottomNavigationBar: SizedBox(height: 50),
    );
  }

  Widget _buildItemWidget(Board board) {
    return GestureDetector(
      onTap: () {
        Get.to(const BoardDetail(), arguments: board);
      },
      child: Card(
        child: SizedBox(
          height: 100,
          child: Row(children: [
            const SizedBox(width: 10),
            const CircleAvatar(
              backgroundImage: AssetImage(
                'assets/images/noticeicon.png',
              ),
              radius: 25,
            ),
            const SizedBox(width: 10), // 원하는 간격 설정
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(240, 0, 0, 0),
                  child: Text(
                    board.date,
                    style: const TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 25),
                  child: Text(
                    board.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }


 void checkSharedPreferences() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedUserId = prefs.getString('userId');
    String? savedUserName = prefs.getString('userName');

    if (savedUserId == 'admin' && savedUserName == '관리자') {
      Get.to(const BoardInsert());
    } else {
      Get.snackbar(
        "ERROR",
        "권한이 없습니다.",
        snackPosition: SnackPosition.BOTTOM,
        duration: Duration(seconds: 2),
        backgroundColor: Color.fromARGB(255, 206, 205, 205),
      );
    }
  }
}





