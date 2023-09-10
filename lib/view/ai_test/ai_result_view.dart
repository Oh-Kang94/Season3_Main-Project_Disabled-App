import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../../components/ai_test/ai_result_widget.dart';
import '../../vm/ai_test/ai_test_controller.dart';


class AiResultView extends StatelessWidget {
  const AiResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: GetBuilder<AiTestController>(
        builder: (controller) {
          return const SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AiResultWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
} // End
