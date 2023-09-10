import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/webclass.dart';

class Mainview extends StatefulWidget {
  const Mainview({Key? key}) : super(key: key);

  @override
  State<Mainview> createState() => _MainviewState();
}

class _MainviewState extends State<Mainview> {
  late List<String> siteTextList;
  late List siteList;
  late List imagesFile;
  late int currentPage;
  late List<IconData> iconList;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    iconList = [
      Icons.work,
      Icons.account_balance,
      Icons.business,
      Icons.info,
    ];

    siteTextList = [
      '취업정보',
      '고용공단',
      '서울기업지원센터',
      '한국고용정보원',
    ];
    siteList = [
      'www.worktogether.or.kr',
      'www.kead.or.kr',
      'sbsc.sba.kr',
      'www.keis.or.kr',
    ];

    imagesFile = [
      'withtogether.png',
      'withdisabled.jpg',
      'withwith.jpg',
    ];
    currentPage = 0;

    //Timer구동 : Timer가 쓰는 시간과 build가 쓰는 시간을 동일화 시킨다 (async)
    /* private으로 선언해서,
      timer를 수정 가능하기 편한 형태로 바꾼다.
    */
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      changeImage();
    });
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Image.asset(
            'assets/images/${imagesFile[currentPage]}',
            width: 400,
            height: 300,
          ),
          const Divider(
            // color: Colors.grey,
            thickness: 1,
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: 260.h,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(), // GridView의 스크롤 동작 비활성화
                shrinkWrap: true, // 필요한 크기만큼만 공간을 차지하도록 설정
                itemCount: siteTextList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 4.0, // 각 항목의 가로:세로 비율을 2:1로 지정 (직사각형 모양)
                  crossAxisCount:1,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Get.to(WebClass(site: siteList[index]));
                    },
                    child: Card(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(iconList[index]),
                          Text(siteTextList[index]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //functions
  changeImage() {
    currentPage++;
    if (currentPage >= imagesFile.length) {
      currentPage = 0;
    }
    setState(() {});
  }
}//End