import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/login/agreement_view.dart';
import 'package:season3_team1_mainproject/util/agreement.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import '../../components/ai_test/ai_age_widget.dart';
import '../../components/ai_test/ai_disabled_widget.dart';
import '../../components/ai_test/ai_employ_day_widget.dart';
import '../../components/ai_test/ai_location_widget.dart';
import '../../components/ai_test/ai_sex_widget.dart';
import '../../vm/ai_test/ai_address_controller.dart';
import 'ai_test_view_jobselect.dart';

class AiTestView extends StatefulWidget {
  const AiTestView({Key? key}) : super(key: key);

  @override
  State<AiTestView> createState() => _AiTestViewState();
}

class _AiTestViewState extends State<AiTestView> {
  final AddressController _controller = Get.put(AddressController());
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
                  const Text(
                    '성별',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  AiSexWidget(),
                  const Text(
                    '생년월일',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  AiAgeWidget(
                    onAgeSelected: _ageSelected,
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
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                                fontSize: 22, fontWeight: FontWeight.bold),
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
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 20,
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
                            style: ElevatedButton.styleFrom(),
                            child: const Text(
                              '근무지역 선택하기',
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            )
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                              "${_controller.addressResult} ${_controller.subAddressResult} ${_controller.subAddresses1Result}",
                              style: const TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                              ),
                              ),
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
                  const SizedBox(
                    height: 50,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      '이용약관',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                              Get.to(const AiTestViewJobSelect());
                            }
                          : null,
                      child: const Text('희망 직업선택',
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

  // 체크박스 그룹화(라디오버튼 안예쁨)
  void _checkboxGroup(bool value) {
    okChecked = value;
    noChecked = !value; // 두 번째 체크박스의 선택 상태를 첫 번째 체크박스와 반대로 설정
    setState(() {});
  }
} // End

