import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/disabledModel.dart';
import '../model/genderModel.dart';
import '../model/userdata.dart';
import '../util/api_endpoint.dart';
import '../view/home.dart';

class RegisterationController extends GetxController {
  TextEditingController idController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController birthController = TextEditingController();
  Rx<DateTime?> selectedBirth = Rx<DateTime?>(null);

  TextEditingController disabledController = TextEditingController();
  Rx<DisabledModel?> selectedDisability = Rx<DisabledModel?>(null);

  TextEditingController genderController = TextEditingController();
  Rx<GenderModel?> selectedgender = Rx<GenderModel?>(null);

  TextEditingController addressController = TextEditingController();

  var consentCollectInfo = false.obs;
  var consentProcessInfo = false.obs;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final registerFormKey = GlobalKey<FormState>();
  final httpClient = GetConnect();

  @override
  void onInit() {
    disabledController.text = '장애 유형 선택';
    genderController.text = '성별 선택';
    birthController.text = '누르시면 생년월일이 검색됩니다.';
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

  // 생년월일 설정
  void setBirthDate(DateTime? date) {
    birthController.text = date.toString().substring(0, 11);
  }

  void toggleConsentCollect(bool newValue) {
    consentCollectInfo.value = newValue;
  }

  void toggleConsentProcess(bool newValue) {
    consentProcessInfo.value = newValue;
  }

  bool get isConsentCollect => consentCollectInfo.value;
  bool get isConsentProcess => consentProcessInfo.value;

  void onSaved() {
    print(birthController.text);
    if (registerFormKey.currentState!.validate() &&
        consentCollectInfo.value == true &&
        consentProcessInfo.value == true) {
      UserData userData = UserData(
        id: idController.text,
        password: passwordController.text,
        name: nameController.text,
        avatar: " ",
        email: emailController.text,
        phone:
            "${phoneController.text.substring(0, 3)}-${phoneController.text.substring(3, 7)}-${phoneController.text.substring(7, 11)}",
        gender: selectedgender.value!.name,
        disability: selectedDisability.value!.name,
        address: addressController.text,
        birth: birthController.text,
      );

      saveUser(userData).then((bool auth) {
        if (auth) {
          Get.snackbar('회원 가입 성공', '성공적으로 회원가입 되었습니다.');
          Get.offAll(const Home());
        } else {
          Get.snackbar('회원가입 실패', '아이디가 중복되었습니다.');
        }
        passwordController.clear();
      });
    }
  }

  Future<bool> saveUser(UserData userData) async {
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.registerid;
    var body = userData.toJson();
    try {
      var response = await GetConnect().post(baseUrl, body);
      print(body);
      if (response.isOk) {
        print(
            "코드는 ${response.body['code'].toString()},결과는 ${response.body['message']}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}
