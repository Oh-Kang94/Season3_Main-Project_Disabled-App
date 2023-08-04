import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
    controller = TabController(length: 0, vsync: this);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: TabBarView(controller: controller, children: const [
          // 각자 페이지 넣기
        ]),
        bottomNavigationBar: Container(
          color: Colors.white,
          child: TabBar(
              controller: controller,
              labelColor: const ColorScheme.light().tertiary, // 선택 되어 있는 아이콘의 색깔 보여주기
              unselectedLabelColor: Colors.red, // 선택 되어있지 않은 아이콘의 색깔 보여주기
              indicatorColor: Colors.blue, // 아래 선택되어 있는 바 보여주기
              indicatorWeight: 10, // 바의 크기 키우기
              tabs: const [
                // 각자 탭바 채워 넣기
                //  3rd Jty
                //  4th Oh_Kang94
              ]),
        ),
        drawer: Drawer(
          child: Container(
            color: Theme.of(context).colorScheme.secondary,
            child: MaterialButton(
              onPressed: () {
                Get.changeThemeMode(
                    Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
              },
            ),
          ),
        ));
  }
}
