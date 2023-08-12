import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/home.dart';

import '../util/api_endpoint.dart';
import '../view/login/findpassword_login.dart';

class FindIdController extends GetxController {
  TextEditingController emailController = TextEditingController();
  String? id;

  final findidFormKey = GlobalKey<FormState>();

  /// ID찾아서 이메일 찾기
  findId() async {
    if (findidFormKey.currentState!.validate()) {
      getId().then((success) {
        if (success) {
          showFindDialog();
        } else {
          Get.defaultDialog(
              title: "ID를 찾을 수 없습니다.",
              middleText: "죄송합니다. 다시 한번 이메일을 확인 부탁드립니다.");
        }
      });
    }
  }

  /// 찾았다는 다이얼로그 보여주기
  showFindDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('ID를 찾았습니다.'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('귀하의 아이디는 '),
            Text(
              id!,
              style: const TextStyle(fontFamily: "NotoSansKR-Bold"),
            ),
            const Text('입니다.'),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.offAll(
                        () => const Home(),
                      );
                    },
                    child: const Text('로그인 하러 가기'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Get.to(() => const FindPasswordView(), arguments: id);
                    },
                    child: const Text('비밀번호 찾기'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  getId() async {
    String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.findId;
    String requestUrl = '$baseUrl?email=${emailController.text}';
    try {
      var response = await GetConnect().get(requestUrl);
      id = response.body['id'];
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
