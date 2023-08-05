import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';

class LoginController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    idController.text = '';
    super.onInit();
  }

  @override
  void onClose() {
    idController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return '아이디와 패스워드를 채워주세요.';
    }
    return null;
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      checkUser(idController.text, passwordController.text).then((bool auth) {
        if (auth) {
          Get.snackbar('로그인 성공', '성공적으로 로그인 되었습니다.');
        } else {
          Get.snackbar('로그인 실패', '아이디와 패스워드를 확인해 주세요');
        }
        passwordController.clear();
      });
    }
  }

  // Api Simulation
  Future<bool> checkUser(String user, String password) async {
    String baseUrl = "http://localhost:3000/login";

    String requestUrl = "$baseUrl/?id=$user&password=$password";

    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);

      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        // 응답이 성공적으로 받아졌을 경우
        print("코드는 ${response.body['code'].toString()},결과는 ${response.body['message']}");
        String token = response.body['token'];

        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

        String type = decodedToken['type'];
        String id = decodedToken['id'];
        String password = decodedToken['password'];

        // 토큰이 유효하면 true를 반환합니다.
        return true;
      } else {
        // 응답이 실패하거나 오류가 발생한 경우 false를 반환합니다.
        return false;
      }
    } catch (e) {
      // 오류가 발생한 경우 false를 반환합니다.
      print(e);
      return false;
    }
  }
}
