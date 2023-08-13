import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import 'package:season3_team1_mainproject/view/register/update_user.dart';
import 'package:season3_team1_mainproject/vm/withdrawal_ctrl.dart';

import '../drawer/agreement.dart';

class ChangeUser extends StatelessWidget {
  const ChangeUser({super.key});

  @override
  Widget build(BuildContext context) {
    final WithdrawalController controller = Get.put(WithdrawalController());
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ListTile(
              onTap: () {
                Get.to(UpdateUser());
              },
              minVerticalPadding: 10.h,
              leading: const Icon(Icons.settings),
              title: const Text(
                "회원 정보 수정",
                style: TextStyle(fontFamily: "NotoSansKR-Bold"),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(
                  const AgreementView(),
                );
              },
              minVerticalPadding: 10.h,
              leading: const Icon(
                Icons.book,
              ),
              title: const Text(
                "회원 약관 읽기",
                style: TextStyle(fontFamily: "NotoSansKR-Bold"),
              ),
            ),
            ListTile(
              onTap: () {
                controller.showWithdrawal();
              },
              minVerticalPadding: 10.h,
              leading: const Icon(
                Icons.run_circle,
              ),
              title: const Text(
                "회원탈퇴",
                style: TextStyle(fontFamily: "NotoSansKR-Bold"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
