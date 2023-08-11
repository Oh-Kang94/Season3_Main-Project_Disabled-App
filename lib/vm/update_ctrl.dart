import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:season3_team1_mainproject/view/home.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/disabled_model.dart';
import '../model/gender_model.dart';
import '../model/user_model.dart';
import '../util/api_endpoint.dart';

class UpdateController extends GetxController {
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

  UserData? userData;

  final updateFormKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    await getSharedPreferences();
    setUser();
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
    if (updateFormKey.currentState!.validate() &&
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

  /// user id 불러내는 것.
  loadUser(String id) async {
    String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.getUser;
    String requestUri = "$baseUrl/?id=$id";
    print("id는 $id");
    try {
      var response = await GetConnect().get(requestUri);
      if (response.isOk) {
        userData = UserData.fromJson(response.body);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// controller.text에 값 넣기
  setUser() async {
    await loadUser(idController.text);
    await getPic(idController.text);
    nameController.text = userData!.name;
    emailController.text = userData!.email;
    phoneController.text = userData!.phone.substring(0, 3) +
        userData!.phone.substring(4, 8) +
        userData!.phone.substring(9, 13);
    birthController.text = userData!.birth.substring(0, 10);
    disabledController.text = userData!.email;
    genderController.text = userData!.gender;
    addressController.text = userData!.address;
  }

  /// profile 사진 가져오기
  Future<bool> getPic(String userid) async {
    String baseUrl =
        ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.getpicPath;

    String requestUrl = "$baseUrl/?id=$userid";
    print(requestUrl);
    try {
      // GetConnect를 사용하여 GET 요청을 보냅니다.
      var response = await GetConnect().get(requestUrl);

      // 응답 데이터를 확인합니다.
      if (response.isOk) {
        // send로 보내서, 그냥 하나만 보내게 됨
        path.value = response.body;
        var ref = FirebaseStorage.instance.ref(path.value.trim());
        print("pic경로는 ${path.value}");
        path.value = await ref.getDownloadURL();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  /// Sharedpref으로 아이디 부르기
  getSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      idController.text = userId ?? ''; // userId가 null이면 빈 문자열로 초기화
    } catch (e) {
      print(e);
    }
    print("UPDATE LOAD SHAREDPREFERENCE: userid: ${idController.text}");
  }
}
