import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

import '../model/aiTestModel.dart';

class AiResultWidget extends StatelessWidget {
  AiResultWidget({super.key});

  // Property
  String result = "";
  final AiTestController aiController = Get.find();

  @override
  Widget build(BuildContext context) {
    int selectedSex = aiController.sexSelected.value;

    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              Text('당신이 합격할 확률은 ${selectedSex == 1 ? '남성' : '여성'} %입니다.'),
              Text(aiController.age.value.toString()),
              Text('${aiController.disabledSelect}'),
              Text('${aiController.radioDisabledSelect == 1 ? '경증' : '중증'}'),
              Text('${aiController.employMonth}'),
              Text('${aiController.selectJob}'),
            ],
          ),
        );
      },
    );
  }
}

// End