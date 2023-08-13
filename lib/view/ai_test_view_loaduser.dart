import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/agreement_view.dart';
import 'package:season3_team1_mainproject/components/ai_age_widget.dart';
import 'package:season3_team1_mainproject/components/ai_disabled_widget.dart';
import 'package:season3_team1_mainproject/components/ai_employ_day_widget.dart';
import 'package:season3_team1_mainproject/components/ai_location_widget.dart';
import 'package:season3_team1_mainproject/components/ai_sex_widget.dart';
import 'package:season3_team1_mainproject/util/agreement.dart';
import 'package:season3_team1_mainproject/view/ai_test_view_jobselect.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import 'package:season3_team1_mainproject/vm/ai_test_controller.dart';

import '../vm/ai_address_controller.dart';

class AiTestViewLoadUser extends StatefulWidget {
  const AiTestViewLoadUser({Key? key}) : super(key: key);

  @override
  State<AiTestViewLoadUser> createState() => _AiTestViewLoadUserState();
}

class _AiTestViewLoadUserState extends State<AiTestViewLoadUser> {
  final AiTestController tController = Get.put(AiTestController());
  final AddressController _controller = Get.put(AddressController());
  // final AiTestController controller =
  //     Get.find<AiTestController>(); // 컨트롤러 인스턴스 생성

  // late int selectedYear;
  // late int selectedMonth;
  // late int selectedDay;
  bool okChecked = false;
  bool noChecked = false;

  String selectedDropdown = "";
  int selected = 0;
  bool disableVisible = false;
  bool employVisible = false;
  bool locationVisible = false;
  bool jobSelectVisible = false;

  @override
  Widget build(BuildContext context) {
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
                    Text('이름: ${tController.userData!.name}'),
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      '성별',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    AiSexWidget(),
                    const Text(
                      '연령',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: AiAgeWidget(
                        onAgeSelected: _ageSelected,
                      ),
                    ),
                    Visibility(
                      visible: disableVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              '장애유형',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            AiDisableWidget(
                              onDisabledSelected: _disabledSelected,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: employVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              '희망 취업일자',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            AiEmployDayWidget(
                              onEmploySelected: _employSelected,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Visibility(
                      visible: locationVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const Text(
                              '희망 근무지역',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
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
                            Text(
                                "${_controller.address_result} ${_controller.subAddress_result} ${_controller.subAddresses1_result}"),
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
                    ),
                    // AiJobSelectWidget(),
                    const Text(
                      '이용약관',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const Text('동의시에만 검사가 가능합니다'),
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
                    AgreementViewWidget(
                      agreement: Agreement.personalCollection,
                      height: 100.h,
                    ),
                    AgreementViewWidget(
                      agreement: Agreement.personalUseage,
                      height: 100.h,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      // 동의에 체크 돼있어야지 검사 시작 가능
                      child: ElevatedButton(
                        onPressed: okChecked
                            ? () {
                                Get.to(AiTestViewJobSelect());
                                // Navigator.pop(context);
                                // Get.to(AiResultView());
                                // showDialog(
                                //   context: context,
                                //   barrierDismissible:
                                //       false, // 사용자가 다이얼로그 바깥을 터치해도 닫히지 않도록 설정합니다.
                                //   builder: (context) => LoadingDialog(),
                                // );
                                // Future.delayed(const Duration(milliseconds: 1500),
                                //     () {
                                //   Get.back();
                                //   Get.to(() => AiResultView());
                                // });
                              }
                            : null,
                        child: const Text('희망 직업선택'),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                  ],
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
  // --- Functions ---

  // 연령 항목 선택시 장애유형 항목 등장
  void _ageSelected(int year, int month, int day) {
    if (year != 0 && month != 0 && day != 0) {
      setState(() {
        disableVisible = true;
      });
    } else {
      setState(() {
        disableVisible = false;
      });
    }
  }

  // 장애유형 항목 선택시 취업일자 항목 등장
  void _disabledSelected(String selectedDropdown, int selected) {
    if (selectedDropdown != "" && selected != 0) {
      setState(() {
        employVisible = true;
      });
    } else {
      setState(() {
        employVisible = false;
      });
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

  // 지역항목 선택시 체크박스 항목 등장
  // void _jobSelectVisible() {
  //   if (_controller.addressStatus = true) {
  //     jobSelectVisible = true;
  //   } else {
  //     jobSelectVisible = false;
  //   }
  //   // jobSelectVisible = _controller.addressStatus;
  //   setState(() {});
  // }

  // 체크박스 그룹화(라디오버튼 안예쁨)
  void _checkboxGroup(bool value) {
    okChecked = value;
    noChecked = !value; // 두 번째 체크박스의 선택 상태를 첫 번째 체크박스와 반대로 설정
    setState(() {});
  }
} // End

