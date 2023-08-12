import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import 'package:season3_team1_mainproject/vm/find_id_ctrl.dart';

import '../../util/asset_image.dart';
import '../../util/regex.dart';

class FindIdView extends StatelessWidget {
  const FindIdView({super.key});

  @override
  Widget build(BuildContext context) {
    final FindIdController controller = Get.put(FindIdController());
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
                  "ID 찾기",
                  style: TextStyle(fontFamily: "NotoSansKR-Bold", fontSize: 30),
                ),
                Lottie.asset(AssetsImage.FIND_LOTTIE, height: 260.h),
                Form(
                  key: controller.findidFormKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
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
                          controller.findId();
                        },
                        child: const Text('ID 찾기'),
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
