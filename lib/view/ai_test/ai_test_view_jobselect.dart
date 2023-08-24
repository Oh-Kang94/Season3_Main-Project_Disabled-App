import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/ai_job_select_widget.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import 'ai_result_view.dart';

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
                  Get.back();
                  Get.to(() => const AiResultView());
              },
              child: const Text(
                "검사시작",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
