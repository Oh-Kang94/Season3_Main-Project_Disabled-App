import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController with CacheCtrl{
  // 로그인 상태를 저장할 변수
  RxBool isLogged = false.obs;
  RxString userId = "".obs; // 사용자의 id를 저장하는 변수
  RxString userName = "".obs;

  @override
  void onInit() {
    super.onInit();
    // 앱 시작 시 저장된 로그인 상태를 불러옵니다.
    checkLoginStatus();
  }

  void logOut() {
    isLogged.value = false;
    removeToken();
  }

  void login(String? token) async {
    isLogged.value = true;
    //Token is cached
    await saveToken(token);
  }

  void checkLoginStatus() {
    final token = getToken();
    if (token != null) {
      isLogged.value = true;
    }
  }
}

mixin CacheCtrl {
  Future<bool> saveToken(String? token) async {
    final box = GetStorage();
    await box.write(CacheCtrlKey.TOKEN.toString(), token);
    return true;
  }

  String? getToken() {
    final box = GetStorage();
    return box.read(CacheCtrlKey.TOKEN.toString());
  }

  Future<void> removeToken() async {
    final box = GetStorage();
    await box.remove(CacheCtrlKey.TOKEN.toString());
  }
}

enum CacheCtrlKey { TOKEN }