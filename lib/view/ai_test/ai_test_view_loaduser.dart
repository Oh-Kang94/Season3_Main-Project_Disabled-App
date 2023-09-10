import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/login/agreement_view.dart';
import 'package:season3_team1_mainproject/util/agreement.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import '../../components/ai_test/ai_employ_day_widget.dart';
import '../../components/ai_test/ai_location_result_text_widget.dart';
import '../../components/ai_test/ai_location_widget.dart';
import '../../vm/ai_test/ai_test_controller.dart';
import '../../vm/login_ctrl.dart';
import 'ai_test_view_jobselect.dart';

class AiTestViewLoadUser extends StatefulWidget {
  const AiTestViewLoadUser({Key? key}) : super(key: key);

  @override
  State<AiTestViewLoadUser> createState() => _AiTestViewLoadUserState();
}

class _AiTestViewLoadUserState extends State<AiTestViewLoadUser> {
  final AiTestController tController = Get.put(AiTestController());
  final LoginController loginController = Get.find<LoginController>();

  bool okChecked = false;
  bool noChecked = false;

  String selectedDropdown = "";
  int selected = 0;
  bool disableVisible = false;
  bool employVisible = false;
  bool locationVisible = false;
  bool jobSelectVisible = false;

  int selectedYear = DateTime.now().year;
  int selectedMonth = DateTime.now().month;
  int selectedDay = DateTime.now().day;

  late DateTime? birthDateTime;
  int? userYear;
  int? userMonth;
  int? userDay;
  // String birthDate;

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (tController.userData != null) {
      birthDateTime = DateTime.parse(tController.userData!.birth);
      userYear = birthDateTime?.year;
      userMonth = birthDateTime?.month;
      userDay = birthDateTime?.day;
    }

    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: GetBuilder<AiTestController>(
          builder: (controller) {
            if (controller.userData != null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      '성별',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      tController.userData!.gender == "남자"
                          ? tController.userData!.gender = "남성"
                          : tController.userData!.gender = "여성",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 350,
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    const Text(
                      '생년월일',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "$userYear 년 $userMonth 월 $userDay 일생",
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal),
                      ),
                    ),
                    const SizedBox(
                      width: 350,
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            '장애유형',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            tController.userData!.disability,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 350,
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            '희망 취업일자',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          AiEmployDayWidget(
                            onEmploySelected: _employSelected,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          const Text(
                            '희망 근무지역',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AiLocationWidget();
                                },
                              );
                            },
                            child: const Text(
                              '근무지역 선택하기',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const AiLocationResultTextWidget(),
                          const SizedBox(
                            width: 350,
                            child: Divider(
                              color: Colors.grey,
                              thickness: 1.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        '이용약관',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                    AgreementViewWidget(
                      agreement: Agreement.personalCollection,
                      height: 100.h,
                    ),
                    AgreementViewWidget(
                      agreement: Agreement.personalUseage,
                      height: 100.h,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('※ 동의시에만 검사가 가능합니다'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: okChecked,
                                onChanged: (value) => _checkboxGroup(value!),
                              ),
                              const Text('동의'),
                            ],
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: noChecked,
                                onChanged: (value) {
                                  // 두 번째 체크박스를 선택하면 첫 번째 체크박스와 반대로 설정
                                  _checkboxGroup(!value!);
                                },
                              ),
                              const Text('비동의'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      // 동의에 체크 돼있어야지 검사 시작 가능
                      child: ElevatedButton(
                        onPressed: okChecked
                            ? () {
                                tController.age.value = age();
                                disabledSelect();

                                Get.to(const AiTestViewJobSelect());
                              }
                            : null,
                        child: const Text(
                          '희망 직업선택',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              );
            } else {
              return SizedBox(
                height: 690.h,
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
              );
            }
          },
        ),
      ),
    );
  }
  // --- Functions ---

  // 바로 로그인 정보를 불러오지 못해서 추가
  void loadUserData() async {
    await tController.loadUser(); // 데이터 로딩
    setState(() {}); // 화면을 다시 그림
  }

  // 장애유형 분류
  disabledSelect() {
    if (tController.userData!.disability == "시각 장애 경증") {
      tController.radioDisabledSelect = 1;
      tController.disabledSelect = "지적 장애";
    } else if (tController.userData!.disability == "시각 장애 중증") {
      tController.radioDisabledSelect = 0;
      tController.disabledSelect = "지적 장애";
    } else if (tController.userData!.disability == "지체 장애 경증") {
      tController.radioDisabledSelect = 1;
      tController.disabledSelect = "지체 장애";
    } else if (tController.userData!.disability == "지체 장애 중증") {
      tController.radioDisabledSelect = 0;
      tController.disabledSelect = "지체 장애";
    } else if (tController.userData!.disability == "지적 장애 경증") {
      tController.radioDisabledSelect = 1;
      tController.disabledSelect = "지적 장애";
    } else if (tController.userData!.disability == "지적 장애 중증") {
      tController.radioDisabledSelect = 0;
      tController.disabledSelect = "지적 장애";
    } else if (tController.userData!.disability == "청각 장애 경증") {
      tController.radioDisabledSelect = 1;
      tController.disabledSelect = "청각 장애";
    } else if (tController.userData!.disability == "청각 장애 중증") {
      tController.radioDisabledSelect = 0;
      tController.disabledSelect = "청각 장애";
    } else if (tController.userData!.disability == "정신 장애 경증") {
      tController.radioDisabledSelect = 1;
      tController.disabledSelect = "정신 장애";
    } else if (tController.userData!.disability == "정신 장애 중증") {
      tController.radioDisabledSelect = 0;
      tController.disabledSelect = "정신 장애";
    }
    setState(() {});
  }

  // 만나이 계산
  int age() {
    DateTime now = DateTime.now();
    if (userYear != null && userMonth != null && userDay != null) {
      int age = now.year - userYear!;
      if (now.month < userMonth! ||
          (now.month == userMonth && now.day < userDay!)) {
        age--; // 생일이 지나지 않았으면 나이 -1
      }
      return age;
    } else {
      return 0; // 혹은 다른 기본값 설정
    }
  }

  // 취업 희망일자 선택시 지역 항목 등장
  void _employSelected(bool selectStatus) {
    if (selectStatus = true) {
      locationVisible = true;
    } else {
      locationVisible = false;
    }
    setState(() {});
  }

  // 체크박스 그룹화(라디오버튼 안예쁨)
  void _checkboxGroup(bool value) {
    okChecked = value;
    noChecked = !value; // 두 번째 체크박스의 선택 상태를 첫 번째 체크박스와 반대로 설정
    setState(() {});
  }
} // End

