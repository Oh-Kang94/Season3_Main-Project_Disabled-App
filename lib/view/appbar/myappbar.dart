import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/logo_pic.dart';
import 'package:season3_team1_mainproject/view/login/login.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';

import '../../binding/Binding.dart';

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
      title: const LogoPic(
        isappbar: true,
      ),
      actions: [
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(
                () => loginController.isLogged.value
                    ? Text('환영합니다, ${loginController.userName.value}님!')
                    : const Text(
                        "로그인이 필요합니다",
                        style: TextStyle(fontFamily: "NotoSansKR-Light"),
                      ),
              ),
            ],
          ),
        ),
        Tooltip(
            message: "로그인",
            child: Obx(
              () => loginController.isLogged.value
                  ? IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.logout,
                          color: Theme.of(context).colorScheme.error),
                    )
                  : IconButton(
                      onPressed: () {
                        Get.to(
                          const LoginUser(),
                          binding: LoginBinding(),
                        );
                      },
                      icon: const Icon(Icons.login),
                    ),
            )),
      ],
    );
  }
}
