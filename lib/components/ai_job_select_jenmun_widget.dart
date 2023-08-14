import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/vm/ai_test_controller.dart';

class AiJobSelectJenmunWidget extends StatefulWidget {
  const AiJobSelectJenmunWidget({super.key});

  @override
  State<AiJobSelectJenmunWidget> createState() =>
      _AiJobSelectJenmunWidgetState();
}

class _AiJobSelectJenmunWidgetState extends State<AiJobSelectJenmunWidget> {
  final AiTestController controller =
      Get.put(AiTestController()); // 액션 없으면 어사인 부분만 안해주면됨

  List<String> jobList = [
    "관리직(임원·부서장)",
    "교육직",
    "운전·운송직",
    "기계 설치·정비·생산직",
    "전기·전자 설치·정비·생산직",
    "건설·채굴직",
    "인쇄·목재·공예 및 기타 설치·정비·생산직",
    "식품 가공·생산직",
    "섬유·의복 생산직",
    "예술·디자인·방송직",
  ];
  int listCount = -1;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              const Text(".\n.\n"),
              SizedBox(
                height: 250,
                width: 300,
                child: ListView.builder(
                  itemCount: jobList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          listCount = index; // 선택된 항목의 인덱스 저장
                          // controller.selectJob = jobList[index];
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 42,
                          child: Card(
                            color: index == listCount
                                ? Colors.grey // 선택된 항목의 색상
                                : Theme.of(context).cardColor, // 선택되지 않은 항목의 색상
                            child: Column(
                              children: [
                                Text(
                                  jobList[index],
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 52, 113, 54),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
