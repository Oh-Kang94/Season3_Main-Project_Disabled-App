import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/ai_start_view.dart';
import 'package:season3_team1_mainproject/view/drawer/mydrawer.dart';
import 'package:season3_team1_mainproject/view/mainview.dart';
import 'package:season3_team1_mainproject/vm/homeCtrl.dart';

import 'appbar/myappbar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.put(HomeController());
    return Scaffold(
      appBar: const MyAppBar(),
      body: TabBarView(controller: homeController.controller, children: const [
        // 각자 페이지 넣기
        Mainview(),
        // main 자리
        AiFirstView(),
        // map 자리
      ]),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: TabBar(
            controller: homeController.controller,
            labelColor:
            Theme.of(context).colorScheme.error, 
            unselectedLabelColor:
                Theme.of(context).colorScheme.tertiary, 
            indicatorColor: Colors.blue, // 아래 선택되어 있는 바 보여주기
            indicatorWeight: 10, // 바의 크기 키우기
            tabs: const [
              // 각자 탭바 채워 넣기
              Tab(
                icon: Icon(Icons.home),
                text: "메인뷰",
              ),
              //  1st main
              Tab(
                icon: Icon(Icons.recommend),
                text: "일자리추천",
              ),

              //  3rd map
            ]),
      ),
      drawer: const Mydrawer(),
    );
  }
}
