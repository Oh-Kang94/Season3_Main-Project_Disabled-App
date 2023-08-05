import 'package:get/get.dart';

import '../vm/loginCtrl.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}