import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/login/login.dart';

import '../../util/asset_image.dart';
import '../../vm/loginGetx.dart';
import '../home.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.find<LoginController>();

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
          () => loginController.isLoggedIn.value
              ? Text('환영합니다, ${loginController.userName.value}님!')
              : const Text("로그인이 필요합니다"),
        ),
        Tooltip(
          message: "로그인",
          child: IconButton(
            onPressed: () {
              Get.to(const LoginUser());
            },
            icon:
                Icon(Icons.login, color: Theme.of(context).colorScheme.secondary),
          ),
        ),
      ],
    );
  }
}
