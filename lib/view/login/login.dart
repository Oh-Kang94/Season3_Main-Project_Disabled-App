import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:season3_team1_mainproject/view/register/register.dart';

import '../../components/login_form.dart';
import '../../components/logo_pic.dart';
import '../../vm/login_ctrl.dart';

class LoginUser extends StatelessWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const LogoPic(
                  isappbar: false,
                ),
                Lottie.asset('assets/lottie/lottieLogin.json', height: 260.h),
                Container(
                  padding: const EdgeInsets.all(50.0),
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginForm(
                          controller: controller,
                          labelText: '아이디',
                          isPassword: false,
                        ),
                        LoginForm(
                          controller: controller,
                          labelText: '비밀번호',
                          isPassword: true,
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: controller.login,
                                child: const Text('로그인'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(RegisterUser());
                                },
                                child: const Text('회원가입'),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.kakaologin();
                                },
                                child: Image.asset(
                                  "assets/images/kakao_login_medium_narrow.png",
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
