import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../../util/asset_image.dart';

class LoginUser extends StatelessWidget {
  const LoginUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AssetsImage.LOGO,
              width: 300,
              height: 300,
            ),
            TextFormField(
              
            )
          ],
        ),
      ),
    );
  }
}
