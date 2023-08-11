import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:season3_team1_mainproject/view/home.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';

import '../model/disabled_model.dart';
import '../model/gender_model.dart';
import '../model/user_model.dart';
import '../util/api_endpoint.dart';

class RegisterationController extends GetxController {
  TextEditingController idController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  TextEditingController birthController = TextEditingController();
  Rx<DateTime?> selectedBirth = Rx<DateTime?>(null);

  TextEditingController disabledController = TextEditingController();
  Rx<DisabledModel?> selectedDisability = Rx<DisabledModel?>(null);

  TextEditingController genderController = TextEditingController();
  Rx<GenderModel?> selectedgender = Rx<GenderModel?>(null);

  TextEditingController addressController = TextEditingController();

  final RxDouble _latitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;

  final LoginController loginController = Get.find();

  Rx<XFile?> pick = Rx<XFile?>(null);
  RxString path = "default".obs;

  RxBool consentCollectInfo = false.obs;
  RxBool consentProcessInfo = false.obs;

  final registerFormKey = GlobalKey<FormState>();
  final httpClient = GetConnect();

  @override
  void onInit() {
    disabledController.text = '장애 유형 선택';
    genderController.text = '누르시면 성별이 검색됩니다.';
    birthController.text = '누르시면 생년월일이 검색됩니다.';
    addressController.text = '누르시면 주소가 검색됩니다.';
    super.onInit();
  }

  // 장애 설정
  Future<void> showDisabilityPicker(BuildContext context) async {
    double pickerItemHeight = 40.0;
    int itemCount = 10;

    double pickerHeight = pickerItemHeight * itemCount + 200;
    if (pickerHeight > MediaQuery.of(context).size.height * 0.3) {
      pickerHeight = MediaQuery.of(context).size.height * 0.3;
    }
    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: pickerHeight,
          child: CupertinoPicker(
            itemExtent: pickerItemHeight,
            onSelectedItemChanged: (index) {
              selectedDisability.value = disabilities[index];
              disabledController.text = selectedDisability.value.toString();
            },
            children: disabilities
                .map((disability) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(disability.name),
                      ],
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  // 성별 선택
  Future<void> showGenderPicker(BuildContext context) async {
    double pickerItemHeight = 100.0;
    int itemCount = 2;

    double pickerHeight = pickerItemHeight * itemCount + 200;
    if (pickerHeight > MediaQuery.of(context).size.height * 0.3) {
      pickerHeight = MediaQuery.of(context).size.height * 0.3;
    }

    await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: pickerHeight,
          child: CupertinoPicker(
            itemExtent: pickerItemHeight,
            onSelectedItemChanged: (index) {
              selectedgender.value = genders[index];
              genderController.text = selectedgender.value.toString();
            },
            children: genders
                .map((gender) => Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(gender.name),
                      ],
                    ))
                .toList(),
          ),
        );
      },
    );
  }

  // 주소 설정
  void setAddress(String address, double latitude, double longitude) {
    addressController.text = address;
    _latitude.value = latitude;
    _longitude.value = longitude;
  }

  // 생년월일 설정
  void setBirthDate(DateTime? date) {
    birthController.text = date.toString().substring(0, 11);
  }

  // 개인정보 동의 설정
  void toggleConsentCollect(bool newValue) {
    consentCollectInfo.value = newValue;
  }

  void toggleConsentProcess(bool newValue) {
    consentProcessInfo.value = newValue;
  }

  /// 생년월일 나타내는 widget
  Future<void> showBirthPicker(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            maximumDate: DateTime.now(),
            initialDateTime: selectedDate,
            onDateTimeChanged: (DateTime newDate) {
              selectedDate = newDate; // Update the selected date
              setBirthDate(selectedDate);
            },
          ),
        );
      },
    );
  }

  // ImagePicker
  imagePicker() async {
    ImagePicker picker = ImagePicker();
    XFile? pickedImage = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 70, maxHeight: 200.h);
    if (pickedImage != null) {
      pick.value = pickedImage;
    }
  }

  void onSavedPic(XFile? pick) {
    path.value = "/profile/${idController.text}_profile";
    if (pick != null) {
      File file = File(pick.path);
      FirebaseStorage.instance.ref(path.value).putFile(file);
    }
  }

  bool get isConsentCollect => consentCollectInfo.value;
  bool get isConsentProcess => consentProcessInfo.value;

  void onSaved() {
    if (registerFormKey.currentState!.validate() &&
        consentCollectInfo.value == true &&
        consentProcessInfo.value == true) {
      onSavedPic(pick.value);
      UserData userData = UserData(
        id: idController.text,
        password: passwordController.text,
        name: nameController.text,
        avatar: path.value,
        email: emailController.text,
        phone:
            "${phoneController.text.substring(0, 3)}-${phoneController.text.substring(3, 7)}-${phoneController.text.substring(7, 11)}",
        gender: selectedgender.value!.name,
        disability: selectedDisability.value!.name,
        address: addressController.text,
        latitude: _latitude.value,
        longitude: _longitude.value,
        birth: birthController.text,
        kakaoid: loginController.kakaoid.value,
        googleid: loginController.googleid.value,
      );
      saveUser(userData).then((auth) {
        if (auth) {
          Get.snackbar('회원 가입 성공', '성공적으로 회원가입 되었습니다.');
          Get.offAll(
            const Home(),
          );
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
      if (response.isOk) {
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
