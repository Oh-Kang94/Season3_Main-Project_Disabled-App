import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController with GetTickerProviderStateMixin {
  late TabController controller;
  late AnimationController animationController;
  RxString userId = "".obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    getSharedPreferences();
    controller = TabController(length: 4, vsync: this);
  }

  // @override
  // void onClose() {
  //   animationController.dispose(); // Dispose the AnimationController's ticker.
  //   controller.dispose(); // Dispose the TabController's ticker.
  //   super.onClose();
  // }

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
