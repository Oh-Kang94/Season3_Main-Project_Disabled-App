import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

List<String> tilelist = [
  "회원 정보 수정",
  "회원 약관 읽기",
  "회원탈퇴",
];
List<IconData> iconList = [
  Icons.settings,
  Icons.book,
  Icons.run_circle,
];

class ChangeUser extends StatelessWidget {
  const ChangeUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Center(
        child: ListView.builder(
            itemCount: tilelist.length,
            itemExtent: 40.h,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                minVerticalPadding: 10.h,
                leading: Icon(iconList[index]),
                title: Text(
                  tilelist[index],
                  style: const TextStyle(fontFamily: "NotoSansKR-Bold"),
                ),
              );
            }),
      ),
    );
  }
}
