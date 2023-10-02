import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../../components/login/agreement_view.dart';
import '../../util/agreement.dart';

class AgreementView extends StatelessWidget {
  const AgreementView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(children: [
              SizedBox(height: 10.h),
              const Text(
                '개인정보 수집동의',
                style: TextStyle(fontSize: 30, fontFamily: "NotoSansKR-Bold"),
              ),
              SizedBox(height: 10.h),
              AgreementViewWidget(
                agreement: Agreement.personalCollection,
                height: 300.h,
              ),
              SizedBox(height: 10.h),
              const Text(
                '개인정보 처리 동의',
                style: TextStyle(fontSize: 30, fontFamily: "NotoSansKR-Bold"),
              ),
              SizedBox(height: 10.h),
              AgreementViewWidget(
                agreement: Agreement.personalUseage,
                height: 300.h,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
