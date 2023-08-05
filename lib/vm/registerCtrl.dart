import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/util/api_endpoint.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/disabledModel.dart';

class RegisterationController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  RxBool isSwitched = false.obs;

  Rx<DisabledModel?> selectedDisability = Rx<DisabledModel?>(null);

  TextEditingController addressController = TextEditingController();

  final _pwFocusNode = FocusNode();
  final _nameFocusNode = FocusNode();
  final _emailFocusNode = FocusNode();
  final _phoneFocusNode = FocusNode();
  final _sexFocusNode = FocusNode();
  final _addressFocusNode = FocusNode();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final registerFormKey = GlobalKey<FormState>();
  var userSex;
  final httpClient = GetConnect();

  // 장애 선택
  void setSelectedDisability(DisabledModel? disability) {
    selectedDisability.value = disability;
  }

  // 스위치 상태 변경 메서드
  void toggleSwitch(bool value) {
    isSwitched.value = value;
  }
}
