import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/home.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/api_endpoint.dart';

class WithdrawalController extends GetxController {
  final LoginController loginController = Get.find<LoginController>();

  String? id;

  /// 회원 탈퇴 물어보기
  void showWithdrawal() {
    Get.defaultDialog(
      title: "회원 탈퇴 하시겠습니까?",
      middleText: "회원 탈퇴 하시겠습니까?",
      actions: [
        TextButton(
          onPressed: () {
            Get.defaultDialog(
              title: "정말 회원 탈퇴 하시겠습니까?",
              middleText: "정말로 이제는 회원 탈퇴 하시겠습니까?",
              actions: [
                TextButton(
                  onPressed: () {
                    doWithdrawal().then((success) {
                      if (success) {
                        loginController.dologout();
                        Get.off(const Home());
                        Get.snackbar("회원 탈퇴", "성공적으로 회원탈퇴 되었습니다.");
                      } else {
                        Get.snackbar("서버 에러", "다시 시도해 주십시오.");
                      }
                    });
                  },
                  child: const Text('네'),
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('아니오'),
                ),
              ],
            );
          },
          child: const Text('네'),
        ),
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('아니오'),
        ),
      ],
    );
  }

  /// deletedate 추가하기
  doWithdrawal() async {
    await getSharedPreferences();
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.withdrawal;

    String requestUrl = "$baseUrl/?id=$id";
    print(requestUrl);
    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);

      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// get id
  getSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id = prefs.getString('userId');
    } catch (e) {
      print(e);
    }
    print("LOAD SHAREDPREFERENCE: userid: $id ");
  }
}
