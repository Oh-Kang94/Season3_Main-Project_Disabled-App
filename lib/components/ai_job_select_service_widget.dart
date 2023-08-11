import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/vm/ai_test_controller.dart';

class AIJobSelectServiceWidget extends StatefulWidget {
  const AIJobSelectServiceWidget({super.key});

  @override
  State<AIJobSelectServiceWidget> createState() =>
      _AIJobSelectServiceWidgetState();
}

class _AIJobSelectServiceWidgetState extends State<AIJobSelectServiceWidget> {
  List<String> jobList = ["경호·경비·스포츠·레크리에이션직", "영업·미용·예식 서비스직", "음식 서비스직"];
  int listCount = 0;

  final AiTestController controller = Get.put(AiTestController());  // 액션 없으면 어사인 부분만 안해주면됨

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
                          controller.selectJob = jobList[listCount];
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
                                    fontSize: 15,
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
