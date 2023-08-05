import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/disabledModel.dart';
import '../model/genderModel.dart';

class RegisterationController extends GetxController {
  TextEditingController idController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  TextEditingController disabledController = TextEditingController();
  Rx<DisabledModel?> selectedDisability = Rx<DisabledModel?>(null);
  TextEditingController genderController = TextEditingController();
  Rx<GenderModel?> selectedgender = Rx<GenderModel?>(null);

  TextEditingController addressController = TextEditingController();


  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final registerFormKey = GlobalKey<FormState>();
  final httpClient = GetConnect();

  @override
  void onInit() {
    disabledController.text = selectedDisability.value?.name ?? '장애 유형 선택';
    genderController.text = selectedgender.value?.name ?? '성별 선택';
    addressController.text = '누르시면 주소가 검색됩니다.';
    super.onInit();
  }

  // 장애 선택
  void setSelectedDisability(DisabledModel? disability) {
    selectedDisability.value = disability;
  }

  // 장애 선택
  void setSelectedGender(GenderModel? gender) {
    selectedgender.value = gender;
  }

  // 주소 설정
  void setAddress(String address) {
    addressController.text = address;
  }

}
