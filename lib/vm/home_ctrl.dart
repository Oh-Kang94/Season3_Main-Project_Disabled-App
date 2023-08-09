import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController controller;
  RxString userId = "".obs;

  @override
  void onInit() {
    super.onInit();
    getSharedPreferences();
    controller = TabController(length: 3, vsync: this);
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
