import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:season3_team1_mainproject/vm/find_pw_ctrl.dart';

import '../../util/asset_image.dart';
import '../../util/regex.dart';
import '../appbar/myappbar.dart';

class FindPasswordView extends StatelessWidget {
  const FindPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final FindPwController controller = Get.put(FindPwController());
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                const Text(
                  "비밀번호 찾기",
                  style: TextStyle(fontFamily: "NotoSansKR-Bold", fontSize: 30),
                ),
                Lottie.asset(AssetsImage.FIND_LOTTIE, height: 260.h),
                Form(
                  key: controller.findPwFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: controller.idController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            labelText: 'ID',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '내용을 적어주세요.';
                            }
                            if (!RegexForm.idpwRegExp.hasMatch(value)) {
                              return '영어 소문자와 숫자로만 이루어진 10글자 이하로 입력 가능합니다.';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: controller.emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: '이메일',
                          ),
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '내용을 적어주세요.';
                            }
                            if (!RegexForm.emailRegExp.hasMatch(value)) {
                              return '올바른 이메일 주소를 입력해주세요.';
                            }
                            return null;
                          },
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          controller.showVerifyCode();
                        },
                        child: const Text('비밀번호 찾기'),
                      ),
                    ],
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
