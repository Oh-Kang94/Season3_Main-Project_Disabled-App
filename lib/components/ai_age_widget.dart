import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../vm/ai_test_controller.dart';
import '../vm/login_ctrl.dart';

typedef OnAgeSelectedCallback = void Function(
    int selectedYear, int selectedMonth, int selectedDay);

class AiAgeWidget extends StatefulWidget {
  final OnAgeSelectedCallback onAgeSelected; // 선택한 연도, 월, 일자를 전달하기 위한 콜백

  const AiAgeWidget({
    required this.onAgeSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<AiAgeWidget> createState() => _AiAgeWidgetState();
}

class _AiAgeWidgetState extends State<AiAgeWidget> {
  final AiTestController aiTestController = Get.put(AiTestController());
  final LoginController loginController = Get.find<LoginController>();
  // Property
  late List<int> age_year;
  late List<int> age_month;
  late List<int> age_day;
  // late int man_age;

  late DateTime? birthDateTime;
  int? userYear;
  int? userMonth;
  int? userDay;

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  @override
  void initState() {
    super.initState();
    // 초기화 코드 추가
    age_year = [];
    age_month = [];
    age_day = [];

    if (loginController.isLogged.value) {
      String? birthDate = aiTestController.userData?.birth;
      if (birthDate != null) {
        birthDateTime = DateTime.parse(birthDate);
        userYear = birthDateTime?.year;
        userMonth = birthDateTime?.month;
        userDay = birthDateTime?.day;
      }
    } else {
      userYear = selectedYear;
      userMonth = selectedMonth;
      userDay = selectedDay;
    }

    for (int year = 1900; year <= DateTime.now().year; year++) {
      age_year.add(year);
    }
    for (int month = 1; month <= 12; month++) {
      age_month.add(month);
    }
    _updateDayRange(selectedYear, selectedMonth);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      value: userYear,
                      items: age_year
                          .map((year) => DropdownMenuItem(
                                value: year,
                                child: Text("${year.toString()}년"),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          userYear = value!;
                          aiTestController.onYearSelected(value);
                          _updateDayRange(userYear!, selectedMonth);
                          realAdult();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      value: userMonth,
                      items: age_month
                          .map((month) => DropdownMenuItem(
                                value: month,
                                child: Text("${month.toString()}월"),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          userMonth = value!;
                          aiTestController.onMonthSelected(value);
                          _updateDayRange(userMonth!, selectedMonth);
                          realAdult();
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButton<int>(
                      value: userDay,
                      items: age_day
                          .map((day) => DropdownMenuItem(
                                value: day,
                                child: Text("${day.toString()}일"),
                              ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          userDay = value!;
                          realAdult();
                        });
                      },
                    ),
                  ),
                  // Text("년도: $userYear, 월: $userMonth, 일: $userDay"),
                ],
              ),
              // Text("만 widget ${age()}"),

              // Text("나이: ${aiTestController.age}세"),
              const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Functions ---

  // 년도와 월에 따라 다른 최대일자를 업데이트하는 함수(2월은 28일까지, 1월에서 7월까지는 홀수가 31일까지, 4년주기로 2월은 29일까지 적용하기 위해)
  void _updateDayRange(int year, int month) {
    age_day.clear(); // 저장되어 있던 날짜들 삭제
    int daysInMonth =
        DateTime(year, month + 1, 0).day; // nextMonth의 day는 해당 월의 마지막 날짜
    for (int day = 1; day <= daysInMonth; day++) {
      // 해당 월의 날짜 범위를 계산하여 age_day에 추가
      age_day.add(day);
    }
  }

  // 만나이 계산 함수
  int age() {
    DateTime now = DateTime.now();
    int age = now.year - userYear!;
    if (now.month < userMonth! ||
        (now.month == userMonth && now.day < userDay!)) {
      age--; // 생일이 지나지 않았으면 나이 -1
    }
    aiTestController.manAge = age;
    return age;
  }
//   int age() {
//   DateTime now = DateTime.now();
//   int calculatedAge = now.year - userYear!;
//   if (now.month < userMonth! ||
//       (now.month == userMonth && now.day < userDay!)) {
//     calculatedAge--; // 생일이 지나지 않았으면 나이 -1
//   }
//   aiTestController.manAge = calculatedAge; // 컨트롤러의 man_age에 할당
//   return calculatedAge;
// }

  // 최저 취업나이 계산 함수
  realAdult() {
    if (age() < 20) {
      Fluttertoast.showToast(
        msg: "미성년자는 검사가 불가능합니다!",
        gravity: ToastGravity.TOP, // 띄우는 위치
        fontSize: 20,
        toastLength: Toast.LENGTH_LONG, // 띄우는 시간
      );
      selectedYear = DateTime.now().year;
      selectedMonth = DateTime.now().month;
      selectedDay = DateTime.now().day;
    } else {
      widget.onAgeSelected(selectedYear, selectedMonth, selectedDay);
    }
    setState(() {});
  }
} // End
