import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  // 로그인 상태를 저장할 변수
  RxBool isLoggedIn = false.obs;
  RxString userId = "".obs; // 사용자의 id를 저장하는 변수
  RxString userName = "".obs;

  @override
  void onInit() {
    super.onInit();
    // 앱 시작 시 저장된 로그인 상태를 불러옵니다.
    checkLoginStatus();
  }

  void setLoggedIn(bool value, String userId, String userName) async {
    isLoggedIn.value = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    await prefs.setString('userId', userId);
    await prefs.setString('userName', userName);
  }

  // 저장된 로그인 상태를 불러오는 메서드
  void checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;
    userId.value = prefs.getString('userId') ?? "dummyId";
    userName.value = prefs.getString('userName') ?? "홍길동";
  }
}
