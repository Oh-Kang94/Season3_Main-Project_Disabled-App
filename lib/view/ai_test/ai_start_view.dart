import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/login/login.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';

import '../../util/asset_image.dart';
import 'ai_test_view.dart';
import 'ai_test_view_loaduser.dart';


class AiFirstView extends StatelessWidget {
  const AiFirstView({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController loginController = Get.find<LoginController>();
    String username = loginController.userName.value;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                // Get.to(AiTestView());
                if (loginController.isLogged.value) {
                  Get.defaultDialog(
                    title: '$username님의 정보가 있습니다.',
                    middleText: '$username님의 정보로\n테스트를 진행하시겠습니까?',
                    titleStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    middleTextStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.off(const AiTestView()),
                        child: const Text('새 정보로 진행'),
                      ),
                      TextButton(
                        onPressed: () => Get.off(const AiTestViewLoadUser()),
                        child: const Text('내 정보로 진행'),
                      ),
                    ],
                  );
                } else {
                  Get.defaultDialog(
                    title: '로그인이 되어있지 않습니다.',
                    middleText: '로그인 하러 가시겠습니까?',
                    titleStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    middleTextStyle: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.off(const LoginUser());
                        },
                        child: const Text('로그인하기'),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.off(const AiTestView());
                        },
                        child: const Text('비회원 테스트하기'),
                      ),
                    ],
                  );
                }
              },
              child: SizedBox(
                width: 260,
                height: 260,
                child: CircleAvatar(
                  child: SvgPicture.asset(
                    AssetsImage.LOGO,
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            const Text(
              '버튼을 눌러서 추천을 시작!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Functions ---
}
