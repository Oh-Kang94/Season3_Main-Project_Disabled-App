// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motion_tab_bar_v2/motion-tab-bar.dart';
import 'package:season3_team1_mainproject/view/drawer/mydrawer.dart';
import 'package:season3_team1_mainproject/view/mainview.dart';
import 'package:season3_team1_mainproject/vm/home_ctrl.dart';

import 'ai_test/ai_start_view.dart';
import 'appbar/myappbar.dart';
import 'board/community.dart';
import 'mapView.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> tabLabels = ["홈", "일자리 추천", "일자리 지도", "공지사항"];
    final HomeController homeController = Get.find<HomeController>();
    return Scaffold(
      appBar: const MyAppBar(),
      body: TabBarView(
          controller: homeController.controller,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            // 각자 페이지 넣기
            const Mainview(),
            // main 자리
            const AiFirstView(),
            // map 자리
            MapViewPage(),
            // community 자리
            const Community()
          ]),
      bottomNavigationBar: MotionTabBar(
        controller: homeController.controller,
        initialSelectedTab: tabLabels[homeController.initialSelectedTab],
        labels: tabLabels,
        icons: const [
          Icons.home,
          Icons.recommend,
          Icons.map,
          Icons.notifications
        ],
        tabSize: 50,
        tabBarHeight: 55,
        textStyle: const TextStyle(fontFamily: "NotoSansKR-Bold"),
        tabIconColor: Theme.of(context).colorScheme.secondary,
        tabIconSize: 28.0,
        tabIconSelectedSize: 26.0,
        tabSelectedColor: Theme.of(context).colorScheme.onSecondary,
        tabIconSelectedColor: Theme.of(context).colorScheme.onSurface,
        tabBarColor: Theme.of(context).colorScheme.surface,
        onTabItemSelected: (int value) {
          homeController.controller.index = value;
          homeController.onTabItemSelected(value);
        },
      ),
      drawer: const Mydrawer(),
    );
  }
}
