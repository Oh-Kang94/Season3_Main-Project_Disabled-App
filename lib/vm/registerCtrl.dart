import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/util/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterationController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController insertDateController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController sexController = TextEditingController();
  TextEditingController disabledController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final httpClient = GetConnect();

  Future<void> registerwithid() async {
    try {
      var headers = {'Content-Type': 'application/json'};
      var url =
          Uri.parse(ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.loginid);
      Map body = {
        'id': idController.text,
        'password': passwordController.text,
        // 'avatar' : avatarController.text, => 시간 나면, 하기
        'name': nameController.text,
        'insertdate': insertDateController.text,
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'sex': sexController.text.trim(),
        'disabled': disabledController.text.trim(),
        'addresss': addressController.text.trim(),
      };

      final response = await httpClient.post(url.toString(), jsonEncode(body),
          headers: headers);
    } catch (e) {
      

    }
  }
}
