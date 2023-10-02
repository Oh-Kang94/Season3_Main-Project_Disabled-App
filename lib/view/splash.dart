import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:season3_team1_mainproject/util/asset_image.dart';
import 'package:season3_team1_mainproject/view/home.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        children: [
          SvgPicture.asset(
            AssetsImage.LOGO,
            width: 250,
            height: 250,
          ),
          const Text(
            "포용 누리",
            style: TextStyle(fontFamily: "NotoSansKR-Bold", fontSize: 50),
          )
        ],
      ),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 400,
      nextScreen: const Home(), // Home 페이지로 이동
      backgroundColor: Colors.white,
    );
  }
}
