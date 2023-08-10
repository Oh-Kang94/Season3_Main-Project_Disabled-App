import 'package:get/get.dart';

class AiTestController extends GetxController {
  RxInt sexSelected = 0.obs;
  RxInt selectedYear = 0.obs;
  RxInt selectedMonth = 0.obs;
  RxInt selectedDay = 0.obs;
  RxInt age = 0.obs;
  String disabledSelect = "";
  int radioDisabledSelect = 0;
  String disabledData1 = "";
  String employMonth = "";
  String selectJob = "";
  bool jobSelectStatus = false;

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


}
