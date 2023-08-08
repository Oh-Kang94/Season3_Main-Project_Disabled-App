import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:season3_team1_mainproject/view/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/api_endpoint.dart';

class LoginController extends GetxService {
  RxBool isLogged = false.obs;
  RxString userId = "".obs;
  RxString userName = "".obs;
  RxString picPath = "default".obs;

  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void onInit() {
    getSharedPreferences();
    super.onInit();
  }

  @override
  void onClose() {
    idController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void login() {
    if (loginFormKey.currentState!.validate()) {
      checkUser(idController.text, passwordController.text).then((bool auth) {
        if (auth) {
          Get.snackbar('로그인 성공', '성공적으로 로그인 되었습니다.');
          isLogged.value = true;
          Get.offAll(const Home());
          getPic(idController.text);
        } else {
          Get.snackbar('로그인 실패', '아이디와 패스워드를 확인해 주세요');
        }
        passwordController.clear();
      });
    }
  }

  void logout() {
    isLogged.value = false;
    userId.value = "";
    userName.value = "";
    removeSharedPreferences();
  }

  // Api
  Future<bool> checkUser(String user, String password) async {
    String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.loginid;

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
        print("id=$id,name:$name,password: $password");
        userId.value = id;
        userName.value = name;
        saveSharedPreferences();

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  saveSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('userId', userId.value);
      prefs.setString('userName', userName.value);
    } catch (e) {
      print(e);
    }
    print(
        "LOGIN SHAREDPREFERENCE: userid${userId.value} username${userName.value}");
  }

  getSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedUserId = prefs.getString('userId');
      String? savedUserName = prefs.getString('userName');
      if (savedUserId != null && savedUserName != null) {
        userId.value = savedUserId;
        userName.value = savedUserName;
      }
    } catch (e) {
      print(e);
    }
  }

  removeSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('userId');
      prefs.remove('userName');
    } catch (e) {
      print(e);
      print(
          "remove SHAREDPREFERENCE: userid${userId.value} username${userName.value}");
    }
  }

  // profile 사진 가져오기
  Future<bool> getPic(String userid) async {
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.getpicPath;

    String requestUrl = "$baseUrl/?id=$userid";

    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);

      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        // send로 보내서, 그냥 하나만 보내게 됨
        picPath.value = response.body;
        var ref = FirebaseStorage.instance.ref(picPath.value.trim());
        picPath.value = await ref.getDownloadURL();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
