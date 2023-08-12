import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../util/api_endpoint.dart';
import '../view/home.dart';

class FindPwController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController idController = TextEditingController();
  String? pw;
  TextEditingController codeController = TextEditingController();

  final findPwFormKey = GlobalKey<FormState>();

  /// 번호 메일 보내기
  showVerifyCode() {
    if (findPwFormKey.currentState!.validate()) {
      findPw();
    }
  }

  /// ID찾아서 이메일 보내기
  findPw() async {
    sendEmail().then((success) {
      if (success) {
        showCodeDialog();
      } else {
        Get.defaultDialog(
            title: "ID 및 이메일을 찾을 수 없습니다.",
            middleText: "죄송합니다. 다시 한번 ID 및 이메일을 확인 부탁드립니다.");
      }
    });
  }

  /// verifycode를 보냈다.
  sendEmail() async {
    String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.sendemail;
    String requestUrl =
        '$baseUrl?id=${idController.text}&email=${emailController.text}';
    try {
      var response = await GetConnect().get(requestUrl);
      if (response.isOk) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// code 확인
  verifycode() async {
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.verifycode;
    String requestUrl =
        '$baseUrl?id=${idController.text}&email=${emailController.text}&code=${codeController.text}';
    try {
      var response = await GetConnect().get(requestUrl);
      if (response.isOk) {
        pw = response.body['password'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// 찾았다는 다이얼로그 보여주기
  showFindDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('비밀번호를 찾았습니다.'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('귀하의 비밀번호는 '),
            Text(
              pw!,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 코드 입력 다이얼로그
  showCodeDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('비밀번호 찾기'),
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("${emailController.text}로 인증번호를 보내 드렸습니다."),
                const Text("메일 확인 후, 코드 입력부탁드립니다."),
                const SizedBox(height: 20),
                TextFormField(
                  controller: codeController,
                  maxLength: 6,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: '숫자 6자리를 입력해주세요.'),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    verifycode().then((success) {
                      if (success) {
                        showFindDialog();
                      } else {
                        Get.defaultDialog(
                            title: "인증번호 실패",
                            middleText: "죄송합니다. 인증번호를 확인 부탁드립니다.");
                      }
                    });
                  },
                  child: const Text('코드 입력'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
