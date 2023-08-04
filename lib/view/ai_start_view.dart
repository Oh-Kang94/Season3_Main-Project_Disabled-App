import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/ai_test_view.dart';

import '../util/asset_image.dart';

class AiFirstView extends StatelessWidget {
  const AiFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Get.to(AiTestView()),
              child: SvgPicture.asset(
                AssetsImage.LOGO,
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            const Text('버튼을 눌러서 테스트를 시작'),
          ],
        ),
      ),
    );
  }
}