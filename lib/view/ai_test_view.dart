import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/agreementViewWidget.dart';
import 'package:season3_team1_mainproject/components/ai_age_widget.dart';
import 'package:season3_team1_mainproject/components/ai_disabled_widget.dart';
import 'package:season3_team1_mainproject/components/ai_employ_day_widget.dart';
import 'package:season3_team1_mainproject/components/ai_sex_widget.dart';
import 'package:season3_team1_mainproject/util/agreement.dart';
import 'package:season3_team1_mainproject/view/ai_result_view.dart';
import 'package:season3_team1_mainproject/view/ai_start_view.dart';
import 'package:season3_team1_mainproject/view/ai_test_next_view.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../components/ai_job_select_widget.dart';
import '../components/loding_widget.dart';

class AiTestView extends StatefulWidget {
  const AiTestView({Key? key}) : super(key: key);

  @override
  State<AiTestView> createState() => _AiTestViewState();
}

class _AiTestViewState extends State<AiTestView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Center(
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
                child: const Column(
                  children: [
                    Text('희망 근무지역'),
                  ],
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              // AgreementViewWidget(
              //   agreement:
              //       agreement.personalCollection + agreement.personalUseage,
              // ),
              AiJobSelectWidget(),
              const Text('개인정보 수집에 동의하십니까? '),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
              const Text(
                '이용약관',
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // 다이얼로그를 표시합니다.
                    showDialog(
                      context: context,
                      barrierDismissible:
                          false, // 사용자가 다이얼로그 바깥을 터치해도 닫히지 않도록 설정합니다.
                      builder: (context) => LoadingDialog(),
                    );

                    // 일부 로딩 시간을 시뮬레이션하기 위해 Future.delayed() 메서드를 사용합니다.
                    // 실제 코드에서는 이 부분을 로딩 로직으로 대체하시면 됩니다.
                    Future.delayed(Duration(seconds: 1), () {
                      // 로딩 다이얼로그를 닫습니다.
                      Navigator.pop(context);

                      // 다음 화면으로 이동합니다.
                      Get.to(AiResultView());
                    });
                  },
                  child: const Text('검사시작'),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
            ],
          ),
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
    locationVisible = selectStatus;
    setState(() {});
  }

  // 지역항목 선택시 체크박스 항목 등장

  // 체크박스 그룹화(라디오버튼 안예쁨)
  void _checkboxGroup(bool value) {
    okChecked = value;
    noChecked = !value; // 두 번째 체크박스의 선택 상태를 첫 번째 체크박스와 반대로 설정
    setState(() {});
  }
} // End
