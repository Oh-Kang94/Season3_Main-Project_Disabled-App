import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:season3_team1_mainproject/view/home.dart';
import 'package:season3_team1_mainproject/view/register/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/api_endpoint.dart';

class LoginController extends GetxService {
  //PROPERTIES
  RxBool isLogged = false.obs;
  RxString userId = "".obs;
  RxString userName = "".obs;
  RxString picPath = "default".obs;
  Rx<String> kakaoid = "".obs;
  Rx<String> googleid = "".obs;
  User? user;
  GoogleSignInAccount? googleSignInAccount;

  final loginFormKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: ['email'],
      clientId:
          "503199664571-3nm7ef16g7uo6p3n2or3ckuhiv737ici.apps.googleusercontent.com");

  // STATEMANAGEMENT

  @override
  void onInit() {
    getSharedPreferences();
    super.onInit();
  }

  @override
  void onClose() {
    idController.dispose();
    passwordController.dispose();
    removeSharedPreferences();
    super.onClose();
  }

  // FUCTION
  // LOGIN

  void login() {
    if (loginFormKey.currentState!.validate()) {
      checkUser(idController.text, passwordController.text).then((bool auth) {
        if (auth) {
          Get.snackbar('로그인 성공', '성공적으로 로그인 되었습니다.');
          isLogged.value = true;
          saveSharedPreferences();
          getSharedPreferences();
          getPic(idController.text);
          Get.off(const Home());
        } else {
          Get.snackbar('로그인 실패', '아이디와 패스워드를 확인해 주세요');
        }
        passwordController.clear();
      });
    }
  }

  // LOGOUT
  /// Logout 창을 띄어준다.
  void showlogout() {
    Get.defaultDialog(
      title: "로그아웃 하시겠습니까?",
      middleText: "로그아웃 하시겠습니까?",
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
            Get.snackbar("로그아웃", "성공적으로 로그아웃 되었습니다.");
            dologout();
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

  /// 실질적인 로그아웃을 말함.
  void dologout() {
    isLogged.value = false;
    userId.value = "";
    userName.value = "";
    picPath.value = "default";
    user = null;
    tryKaokaologout();
    tryGooglelogout();
    removeSharedPreferences();
  }

  // Api
  /// USER DB CHECK
  Future<bool> checkUser(String user, String password) async {
    String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.loginid;

    String requestUrl = "$baseUrl/?id=$user&password=$password";

    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);

      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        // 응답이 성공적으로 받아졌을 경우
        String token = response.body['token'];

        Map<String, dynamic> decodedToken = Jwt.parseJwt(token);

        String id = decodedToken['id'];
        String name = decodedToken['name'];
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

  /// KAKAO LOGIN
  kakaologin() async {
    isLogged.value = await tryKakaologin();
    User user = await UserApi.instance.me();

    kakaoid.value = user.kakaoAccount?.email ?? "";

    if (isLogged.value) {
      checkKaKaoEnrolled(user.kakaoAccount?.email).then((isEnrolled) {
        if (isEnrolled) {
          Get.snackbar('로그인 성공', '성공적으로 로그인 되었습니다.');
          getPic(userId.value);
          isLogged.value = true;
          saveSharedPreferences();
          getSharedPreferences();
          Get.offAll(const Home());
        } else {
          Get.defaultDialog(
            title: "회원가입 필요",
            middleText: "더 나은 일자리 추천 및 커뮤니티 서비스를 위해서, 회원가입이 필요합니다.",
            onConfirm: () {
              Get.offAll(RegisterUser());
              isLogged.value = false;
            },
            textConfirm: "네",
            onCancel: () async {
              isLogged.value = false;
              tryKaokaologout();
            },
            textCancel: "아니오",
          );
        }
      });
    }

    if (isLogged.value) {
      user = await UserApi.instance.me();
    }
  }

  /// KAKAO 로그인이 처음인가 확인하고, 회원가입까지 가게 하기.
  Future<bool> checkKaKaoEnrolled(String? id) async {
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.checkkakao;

    String requestUrl = "$baseUrl/?id=$id";
    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);
      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        userId.value = response.body['id'];
        userName.value = response.body['name'];
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// 서버에 카카오 로그인을 시도.
  tryKakaologin() async {
    try {
      bool isInstalled = await isKakaoTalkInstalled();
      if (isInstalled) {
        try {
          await UserApi.instance.loginWithKakaoTalk();
          return true;
        } catch (e) {
          return false;
        }
      } else {
        try {
          await UserApi.instance.loginWithKakaoAccount();
          return true;
        } catch (e) {
          return false;
        }
      }
    } catch (error) {
      return false;
    }
  }

  /// 서버에 카카오 로그아웃을 시도.
  tryKaokaologout() async {
    try {
      await UserApi.instance.logout(); // 로그아웃이다.
      // await UserApi.instance.unlink(); // 회원 탈퇴이다.
      return true;
    } catch (error) {
      return false;
    }
  }

  // Google Login

  googlelogin() async {
    googleSignInAccount = await googleSignIn.signIn();
    isLogged.value = true;
    googleid.value = googleSignInAccount?.email ?? "";
    if (isLogged.value) {
      print(googleid.value);
      checkGoogleEnrolled(googleid.value).then((isEnrolled) {
        if (isEnrolled) {
          Get.snackbar('로그인 성공', '성공적으로 로그인 되었습니다.');
          getPic(userId.value);
          saveSharedPreferences();
          getSharedPreferences();
          Get.offAll(const Home());
        } else {
          print("확인2");
          Get.defaultDialog(
            title: "회원가입 필요",
            middleText: "더 나은 일자리 추천 및 커뮤니티 서비스를 위해서, 회원가입이 필요합니다.",
            onConfirm: () {
              Get.offAll(RegisterUser());
              isLogged.value = false;
            },
            textConfirm: "네",
            onCancel: () async {
              isLogged.value = false;
              googleSignIn.disconnect();
            },
            textCancel: "아니오",
          );
        }
      });
    }
  }

  /// GoogleLogout
  tryGooglelogout() async {
    try {
      await googleSignIn.signOut(); // 로그아웃이다.
      // await UserApi.instance.unlink(); // 회원 탈퇴이다.
      return true;
    } catch (error) {
      return false;
    }
  }

  /// Google Login check
  Future<bool> checkGoogleEnrolled(String? id) async {
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.checkgoogle;

    String requestUrl = "$baseUrl/?id=$id";
    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);
      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        userId.value = response.body['id'];
        userName.value = response.body['name'];
        print("구글 로그인 확인${userId.value}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  //
  //
  /// profile 사진 가져오기
  Future<bool> getPic(String userid) async {
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.getpicPath;

    String requestUrl = "$baseUrl/?id=$userid";
    print(requestUrl);
    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);

      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        // send로 보내서, 그냥 하나만 보내게 됨
        picPath.value = response.body;
        var ref = FirebaseStorage.instance.ref(picPath.value.trim());
        print("pic경로는 ${picPath.value}");
        picPath.value = await ref.getDownloadURL();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// Shared Prefernces
  /// Shared Pref 저장
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
}
