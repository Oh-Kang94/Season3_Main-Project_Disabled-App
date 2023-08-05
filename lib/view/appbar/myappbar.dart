import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../util/asset_image.dart';
import '../home.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({
    super.key,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: GestureDetector(
          onTap: () {
            Get.offAll(
              const Home(),
              transition: Transition.noTransition,
            );
          },
          child: SvgPicture.asset(
            AssetsImage.LOGO,
            height: 50,
            width: 50,
          )),
    );
  }
}
