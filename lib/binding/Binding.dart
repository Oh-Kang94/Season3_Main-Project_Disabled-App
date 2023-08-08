import 'package:get/get.dart';

import '../vm/login_ctrl.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
