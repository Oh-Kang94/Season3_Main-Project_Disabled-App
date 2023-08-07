import 'package:flutter/material.dart';
import 'package:season3_team1_mainproject/components/ai_age_widget.dart';
import 'package:season3_team1_mainproject/components/ai_disabled_widget.dart';
import 'package:season3_team1_mainproject/components/ai_employ_day_widget.dart';
import 'package:season3_team1_mainproject/components/ai_sex_widget.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

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
              Column(
                children: [
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
                  GestureDetector(
                    onTap: () {
                      
                    },
                    child: const Text(
                      '이용약관',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text('검사시작'),
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
