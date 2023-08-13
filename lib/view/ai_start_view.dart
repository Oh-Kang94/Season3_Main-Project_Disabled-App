import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/ai_test_view.dart';
import 'package:season3_team1_mainproject/view/ai_test_view_loaduser.dart';
import 'package:season3_team1_mainproject/view/login/login.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../util/asset_image.dart';

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
                    // backgroundColor: Colors.yellowAccent,
                    // barrierDismissible: false,
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
                    middleText: '로그인을 하러 가시겠습니까?',
                    // backgroundColor: Colors.yellowAccent,
                    // barrierDismissible: false,
                    actions: [
                      Row(
                        children: [
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
                            child: const Text('비회원 정보로 테스트하기'),
                          ),
                        ],
                      ),
                    ],
                  );
                }
              },
              child: SvgPicture.asset(
                AssetsImage.LOGO,
                width: 300,
                height: 300,
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

  // --- Functions ---
}
