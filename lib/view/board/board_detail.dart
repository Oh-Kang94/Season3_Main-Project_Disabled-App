import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


import '../../model/board_model.dart';
import '../../vm/home_ctrl.dart';
import '../appbar/myappbar.dart';
import '../home.dart';
import 'board_update.dart';

class BoardDetail extends StatefulWidget {
  const BoardDetail({super.key});

  @override
  State<BoardDetail> createState() => _BoardDetailState();
}

class _BoardDetailState extends State<BoardDetail> {
  late TextEditingController commentController;
  late TextEditingController commentUpdateController;
  bool isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    commentController = TextEditingController();
    commentUpdateController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    var board = Get.arguments ?? "_";
    board = Get.arguments as Board?;
    if (board != null) {
      commentUpdateController.text = board.comment ?? "";
    }
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(children: [
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
            const SizedBox(
              height: 10,
            ),
            const Divider(
              thickness: 1.0,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 15,
                ),
                const SizedBox(
                  width: 300,
                ),
                Text(board.date),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  board.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const Divider(
                  thickness: 1.0,
                ),
                const SizedBox(
                  height: 10,
                  width: 5,
                ),
                Text(
                  board.content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 180,
                ),
                const Divider(
                  thickness: 1.0,
                ),
                const SizedBox(
                  width: 10,
                  height: 100,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: isButtonEnabled
                          ? () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? savedUserId = prefs.getString('userId');
                              String? savedUserName =
                                  prefs.getString('userName');

                              if (savedUserId == 'admin' &&
                                  savedUserName == '관리자') {
                                board?.ref.update(
                                  {
                                    'title': board.title,
                                    'content': board.content
                                  },
                                );
                                Get.to(const BoardUpdate(), arguments: board);
                              } else {
                                setState(() {
                                  isButtonEnabled = false;
                                });
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                            child: Icon(
                              Icons.edit_outlined,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                            child: Text('수정'),
                          ),
                        ],
                      ),
                      label: const SizedBox.shrink(),
                    ),
                    ElevatedButton.icon(
                      onPressed: isButtonEnabled
                          ? () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              String? savedUserId = prefs.getString('userId');
                              String? savedUserName =
                                  prefs.getString('userName');

                              if (savedUserId == 'admin' &&
                                  savedUserName == '관리자') {
                                Get.defaultDialog(
                                  title: '삭제',
                                  middleText: '게시글을 삭제하시겠습니까?',
                                  barrierDismissible: false,
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text(
                                            '나가기',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            board?.ref.delete();
                                            HomeController homeController =
                                                Get.find();
                                            homeController.controller
                                                .animateTo(3);
                                            Get.off(const Home());
                                          },
                                          style: TextButton.styleFrom(
                                            foregroundColor: Colors.red,
                                          ),
                                          child: const Text(
                                            '삭제',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                );
                              } else {
                                setState(() {
                                  isButtonEnabled = false; // 버튼을 비활성화
                                });
                              }
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                            child: Icon(
                              Icons.delete,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                            child: Text('삭제'),
                          ),
                        ],
                      ),
                      label: const SizedBox.shrink(),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        HomeController homeController = Get.find();
                        homeController.controller.animateTo(3);
                        Get.to(const Home());
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(50, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      icon: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                            child: Icon(
                              Icons.menu,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(12, 2, 0, 0),
                            child: Text('목록'),
                          ),
                        ],
                      ),
                      label: const SizedBox.shrink(),
                    ),
                  ],
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
