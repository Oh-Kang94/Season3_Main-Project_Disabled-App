import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/model/aiTestModel.dart';

class AiJobSelectWidget1 extends StatefulWidget {
  const AiJobSelectWidget1({super.key});

  @override
  State<AiJobSelectWidget1> createState() => _AiJobSelectWidget1State();
}

class _AiJobSelectWidget1State extends State<AiJobSelectWidget1> {
  List<String> jobList = [
    "제조 단순직",
    "보건·의료직",
    "음식 서비스직",
    "경호·경비직",
    "인쇄·목재·공예 및 기타 설치·정비·생산직",
    "영업·판매직",
    "돌봄 서비스직(간병·육아)",
    "전기·전자 설치·정비·생산직",
    "운전·운송직",
    "스포츠·레크리에이션직",
    "식품 가공·생산직",
    "미용·예식 서비스직",
    "기계 설치·정비·생산직",
    "사회복지·종교직",
    "섬유·의복 생산직",
    "관리직(임원·부서장)",
    "교육직",
    "예술·디자인·방송직",
    "건설·채굴직",
  ];
  int listCount = 0;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              SizedBox(
                height: 650,
                width: 300,
                child: ListView.builder(
                  itemCount: jobList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          listCount = index; // 선택된 항목의 인덱스 저장
                          controller.selectJob = jobList[index];
                          setState(() {});
                        },
                        child: SizedBox(
                          height: 40,
                          child: Card(
                            color: index == listCount
                                ? Colors.grey // 선택된 항목의 색상
                                : Colors.white, // 선택되지 않은 항목의 색상
                            child: Column(
                              children: [
                                Text(jobList[index]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.all(20.0),
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: const Text('직종선택완료'),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }
}
