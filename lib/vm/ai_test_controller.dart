import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user_model.dart';
import '../util/api_endpoint.dart';

class AiTestController extends GetxController {
  String? userId;
  UserData? userData;

  RxInt sexSelected = 0.obs;
  RxInt selectedYear = 0.obs;
  RxInt selectedMonth = 0.obs;
  RxInt selectedDay = 0.obs;
  RxInt age = 0.obs;
  String disabledSelect = "지적장애";
  int radioDisabledSelect = 1;
  String disabledData1 = "";
  String employMonth = "";
  String selectJob = "";
  bool jobSelectStatus = false;

  @override
  void onInit() {
    loadUser();
    super.onInit();
  }

  void onSexSelected(int value) {
    sexSelected.value = value;
    _updateAge();
  }

  void onYearSelected(int value) {
    selectedYear.value = value;
    _updateAge();
  }

  void onMonthSelected(int value) {
    selectedMonth.value = value;
    _updateAge();
  }

  void _updateAge() {
    DateTime now = DateTime.now();
    int calculatedAge = now.year - selectedYear.value;
    if (now.month < selectedMonth.value ||
        (now.month == selectedMonth.value && now.day < selectedDay.value)) {
      calculatedAge--; // 생일이 지나지 않았으면 나이 -1
    }
    age.value = calculatedAge;
  }

  // void disabledData(){
  //   radioDisabledSelect == 1 ? disabledData1 =  "경증" : disabledData1 =  "중증";
  //   print(disabledData1);
  //   update();
  // }

  /// user id 불러내는 것.
  ///

  // Future<void> loadUser() async {
  //   await getSharedPreferences();
  //   if (userId != null) {
  //     String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.getUser;
  //     String requestUri = "$baseUrl/?id=$userId";
  //     try {
  //       var response = await GetConnect().get(requestUri);
  //       if (response.isOk) {
  //         userData = UserData.fromJson(response.body);
  //         print("이름은 이래: username: ${userData!.name}");
  //         update(); // 상태 업데이트
  //       }
  //     } catch (e) {
  //       print(e);
  //     }
  //   }
  // }
  loadUser() async {
    await getSharedPreferences();
    if (userId != null) {
      String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.getUser;
      String requestUri = "$baseUrl/?id=$userId";
      try {
        var response = await GetConnect().get(requestUri);
        if (response.isOk) {
          userData = UserData.fromJson(response.body);
          print("이름은 이래: username: ${userData!.name}");
          update();
          return true;
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    }
  }

  getSharedPreferences() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      userId = prefs.getString('userId');
    } catch (e) {
      print(e);
    }
    print("LOAD SHAREDPREFERENCE: userid: $userId");
  }
}
