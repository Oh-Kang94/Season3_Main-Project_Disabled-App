import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/login/login.dart';

import '../../binding/Binding.dart';
import '../../util/asset_image.dart';
import '../../vm/AuthCtrl.dart';
import '../home.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    AuthController authController = Get.find<AuthController>();

    return AppBar(
      title: GestureDetector(
        onTap: () {
          Get.offAll(
            const Home(),
            transition: Transition.noTransition,
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SvgPicture.asset(
              AssetsImage.LOGO,
              height: 50,
              width: 50,
            ),
          ],
        ),
      ),
      actions: [
        Obx(
          () => authController.isLogged.value
              ? Text('환영합니다, ${authController.userName.value}님!')
              : const Text("로그인이 필요합니다"),
        ),
        Tooltip(
          message: "로그인",
          child: IconButton(
            onPressed: () {
              Get.to(
                const LoginUser(),
                binding: LoginBinding(),
              );
            },
            icon: Icon(Icons.login,
                color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ],
    );
  }
}
