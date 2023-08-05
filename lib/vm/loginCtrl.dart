import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:season3_team1_mainproject/view/home.dart';

class LoginController extends GetxController {
  RxBool isLogged = false.obs;
  RxString userId = "".obs; // 사용자의 id를 저장하는 변수
  RxString userName = "".obs;

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
          isLogged.value = true;
          Get.offAll(const Home());
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
        print(
            "코드는 ${response.body['code'].toString()},결과는 ${response.body['message']}");

        String token = response.body['token'];

        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

        String id = decodedToken['id'];
        String password = decodedToken['password'];
        String name = decodedToken['name'];
        print("id=${id},name:${name},password: ${password}");
        userId.value = id;
        userName.value = name;

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  void logout() {
    isLogged.value = false;
    userId.value = "";
    userName.value = "";
  }
}
