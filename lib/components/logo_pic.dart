import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../util/asset_image.dart';
import '../view/home.dart';

class LogoPic extends StatelessWidget {
  const LogoPic({
    super.key,
    required this.isappbar,
  });

  final bool isappbar;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.offAll(
          const Home(),
          transition: Transition.noTransition,
        );
      },
      child: Row(
        mainAxisAlignment:
            isappbar ? MainAxisAlignment.end : MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            AssetsImage.LOGO,
            height: 40.h,
            width: 40.h,
          ),
        ],
      ),
    );
  }
}
