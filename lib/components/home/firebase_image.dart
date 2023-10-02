import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/asset_image.dart';

class FirebaseImageWidget extends StatelessWidget {
  const FirebaseImageWidget({Key? key, this.size, required this.imagePath})
      : super(key: key);

  final double? size;
  final String imagePath;
  @override
  Widget build(BuildContext context) {
    return imagePath != "default"
        ? CircleAvatar(
            radius: size ?? 40.h,
            backgroundImage: NetworkImage(
              imagePath,
            ),
          )
        : const CircleAvatar(
            backgroundImage: AssetImage(AssetsImage.PROFILE_IMAGE));
  }
}
