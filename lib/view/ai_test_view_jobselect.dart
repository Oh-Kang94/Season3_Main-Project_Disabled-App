import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/ai_job_select_widget.dart';
import 'package:season3_team1_mainproject/view/ai_result_view.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../components/loding_widget.dart';

class AiTestViewJobSelect extends StatelessWidget {
  const AiTestViewJobSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 400, 
              height: 600, 
              child: AiJobSelectWidget(),
              ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible:
                      false, // 사용자가 다이얼로그 바깥을 터치해도 닫히지 않도록 설정합니다.
                  builder: (context) => LoadingDialog(),
                );
                Future.delayed(const Duration(milliseconds: 1500), () {
                  Get.back();
                  Get.to(const AiResultView());
                });
              },
              child: const Text("검사시작"),
            ),
          ],
        ),
      ),
    );
  }
}
