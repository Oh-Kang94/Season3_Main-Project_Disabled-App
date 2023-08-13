import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late MotionTabBarController controller;
  RxString userId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getSharedPreferences();
    controller = MotionTabBarController(length: 4, vsync: this);
  }

  @override
  void onClose() {
    controller.dispose(); // Dispose the TabController's ticker.
    super.onClose();
  }

  getSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? savedUserId = prefs.getString('userId');
      if (savedUserId != null) {
        userId.value = savedUserId;
      }
    } catch (e) {
      print(e);
    }
  }
}
