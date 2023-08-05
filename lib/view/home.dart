import 'package:flutter/material.dart';
import 'package:season3_team1_mainproject/view/ai_start_view.dart';
import 'package:season3_team1_mainproject/view/drawer/mydrawer.dart';

import 'appbar/myappbar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  // Prioperties
  late TabController controller;

  @override
  void initState() {
    super.initState();
    controller = TabController(length: 1, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: TabBarView(controller: controller, children: const [
        // 각자 페이지 넣기
        // main 자리
        AiFirstView(),
        // map 자리
      ]),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: TabBar(
            controller: controller,
            labelColor:
                Theme.of(context).colorScheme.tertiary, // 선택 되어 있는 아이콘의 색깔 보여주기
            unselectedLabelColor:
                Theme.of(context).colorScheme.error, // 선택 되어있지 않은 아이콘의 색깔 보여주기
            indicatorColor: Colors.blue, // 아래 선택되어 있는 바 보여주기
            indicatorWeight: 10, // 바의 크기 키우기
            tabs: const [
              // 각자 탭바 채워 넣기
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
