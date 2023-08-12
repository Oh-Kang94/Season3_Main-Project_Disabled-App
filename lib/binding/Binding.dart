import 'package:get/get.dart';
import 'package:season3_team1_mainproject/vm/home_ctrl.dart';

import '../vm/login_ctrl.dart';

class MainBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => LoginController());
  }
}
