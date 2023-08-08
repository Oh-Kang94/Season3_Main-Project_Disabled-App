import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/ai_job_select_widget1.dart';
import 'package:season3_team1_mainproject/model/aiTestModel.dart';

class AiJobSelectWidget extends StatefulWidget {
  const AiJobSelectWidget({super.key});

  @override
  State<AiJobSelectWidget> createState() => _AiJobSelectWidgetState();
}

class _AiJobSelectWidgetState extends State<AiJobSelectWidget> {
  // Property
  late bool buttonStatus1;
  late bool buttonStatus2;
  late bool buttonStatus3;

  @override
  void initState() {
    super.initState();
    buttonStatus1 = false;
    buttonStatus2 = false;
    buttonStatus3 = false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              Container(
                color: Theme.of(context).colorScheme.secondary,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            buttonStatus1 = true;
                            buttonStatus2 = false;
                            buttonStatus3 = false;
                            controller.selectJob = '경영·행정·사무직';
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonStatus1 == true
                                ? Colors.grey
                                : Theme.of(context).cardColor,
                          ),
                          child: const Text('경영·행정·사무직'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            buttonStatus1 = false;
                            buttonStatus2 = true;
                            buttonStatus3 = false;
                            controller.selectJob = '청소 및 기타 개인서비스직';
                          },
                          style: ElevatedButton.styleFrom(
                            // 
                            backgroundColor: buttonStatus2 == true
                                ? Colors.grey
                                : Theme.of(context).cardColor,
                          ),
                          child: const Text('청소 및 기타 개인서비스직'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {});
                            buttonStatus1 = false;
                            buttonStatus2 = false;
                            buttonStatus3 = true;
                            // controller.selectJob = '경영·행정·사무직';
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: buttonStatus3 == true
                                ? Colors.grey
                                : Theme.of(context).cardColor,
                          ),
                          child: const Text('기타직종'),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: buttonStatus3,
                child: AiJobSelectWidget1(),
              ),
            ],
          ),
        );
      },
    );
  }
} // End
