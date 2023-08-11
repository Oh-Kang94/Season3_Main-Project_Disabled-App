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
import 'package:season3_team1_mainproject/view/ai_result_view.dart';
import 'package:season3_team1_mainproject/view/ai_start_view.dart';
import 'package:season3_team1_mainproject/view/ai_test_next_view.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../components/ai_job_select_widget.dart';
import '../components/loding_widget.dart';
import '../model/ai_address_model.dart';

class AiTestView extends StatefulWidget {
  const AiTestView({Key? key}) : super(key: key);

  @override
  State<AiTestView> createState() => _AiTestViewState();
}

class _AiTestViewState extends State<AiTestView> {
  final AddressController _controller = Get.put(AddressController());

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
        child: GetBuilder<AddressController>(
          builder: (controller) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  const Text('성별'),
                  AiSexWidget(),
                  const Text('연령'),
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
                          const Text('장애유형'),
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
                          const Text('희망 취업일자'),
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
                          const Text('희망 근무지역'),
                          ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const AiLocationWidget();
                                },
                              );
                            },
                            child: const Text('근무지역 선택하기'),
                          ),
                          Text(
                              "${_controller.address_result} ${_controller.subAddress_result} ${_controller.subAddresses1_result}"),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Visibility(
                    visible: _controller.addressStatus,
                    child: const AiJobSelectWidget(),
                  ),
                  const Text('이용약관'),
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
                    child: ElevatedButton(
                      onPressed: okChecked
                          ? () {
                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => LoadingDialog(),
                              );

                              Future.delayed(const Duration(seconds: 1), () {
                                Navigator.pop(context);
                                Get.to(const AiResultView());
                              });
                            }
                          : null, // "동의" 체크박스가 체크되어야 버튼이 활성화됩니다.
                      child: const Text('검사시작'),
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            );
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

