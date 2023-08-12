import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:season3_team1_mainproject/util/asset_image.dart';
import 'package:season3_team1_mainproject/view/login/findid_login.dart';
import 'package:season3_team1_mainproject/view/register/register_user.dart';

import '../../components/login_form.dart';
import '../../components/logo_pic.dart';
import '../../vm/login_ctrl.dart';
import 'findpassword_login.dart';

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
                Lottie.asset(AssetsImage.LOGIN_LOTTIE, height: 260.h),
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
                          padding: const EdgeInsets.all(4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: controller.login,
                                child: SizedBox(
                                    width: 75.w,
                                    height: 30.h,
                                    child: const Center(
                                      child: Text(
                                        '로그인',
                                      ),
                                    )),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Get.to(
                                    RegisterUser(),
                                  );
                                },
                                child: SizedBox(
                                  width: 75.w,
                                  height: 30.h,
                                  child: const Center(
                                    child: Text('회원가입'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.dialog(
                              AlertDialog(
                                title: const Text('ID 및 비밀번호 찾기'),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Text('아이디나 비밀번호 중 어떤 것을 찾으시나요?'),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.to(() => const FindIdView());
                                            },
                                            child: const Text('ID 찾기'),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Get.to(() =>
                                                  const FindPasswordView());
                                            },
                                            child: const Text('비밀번호 찾기'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("아이디 및 비밀번호를 모른다면..."),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.kakaologin();
                                },
                                child: SizedBox(
                                  width: 110.w,
                                  height: 30.h,
                                  child: Image.asset(
                                    AssetsImage.KAKAO_LOGIN,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  controller.googlelogin();
                                },
                                child: SizedBox(
                                  width: 110.w,
                                  height: 30.h,
                                  child: Image.asset(
                                    AssetsImage.GOOGLE_LOGIN,
                                    fit: BoxFit.fill,
                                  ),
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
