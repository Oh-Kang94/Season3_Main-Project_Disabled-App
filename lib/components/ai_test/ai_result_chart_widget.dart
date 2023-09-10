import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';

import '../vm/ai_test_controller.dart';

class AiResultChartWidget extends StatefulWidget {
  AiResultChartWidget({super.key});

  @override
  State<AiResultChartWidget> createState() => _AiResultChartWidgetState();
}

class _AiResultChartWidgetState extends State<AiResultChartWidget> {
  final AiTestController Tcontroller =
      Get.put(AiTestController()); 
 // 액션 없으면 어사인 부분만 안해주면됨
  List<Color> colorsList = [
    const Color(0xffD95AF3),
    const Color.fromARGB(255, 55, 157, 64),
    const Color.fromARGB(255, 79, 123, 228),
    const Color.fromARGB(255, 239, 153, 40),
    const Color.fromARGB(255, 36, 60, 74),
  ];

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1),
      Color.fromRGBO(254, 154, 92, 1),
    ],
  ];
  @override
  void initState() {
    super.initState();
    reuslt();
  }

  @override
  Widget build(BuildContext context) {
    print("넘어온 결과들111 ${Tcontroller.resultPercent}");
    Map<String, double> dataMap = {
      "경영행정사무직": Tcontroller.resultPercent[0],
      "기타": Tcontroller.resultPercent[1],
      "서비스직": Tcontroller.resultPercent[2],
    };

    return Center(
      child: PieChart(
        dataMap: dataMap, // 데이터 숫자넣어주기
        colorList: colorsList, // 컬러리스트 불러오기
        chartRadius: MediaQuery.of(context).size.width / 2, // 화면의 절반으로 설정
        centerText: "Test", // 가운데 title주기
        chartType: ChartType.disc, // chart 모양 정해주기(default = disc)
        ringStrokeWidth: 50, // ring타입으로 했을 때 굵기 정하기
        animationDuration: const Duration(seconds: 3), // 등장 애니메이션 효과 속도 조절
        chartValuesOptions: const ChartValuesOptions(
          showChartValues: true, // chart의 수치 보일지 숨길지 설정하기
          showChartValuesOutside: true, // chart의 수치 밖으로 빼기
          showChartValuesInPercentage: true, // 차트 수치에 %붙여주기
          showChartValueBackground: false, // 차트 수치 백그라운드 없애기
          chartValueStyle: TextStyle(
              fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        legendOptions: const LegendOptions(
          showLegends: true, // legend 보일지 숨길지 설정하기
          legendShape: BoxShape.rectangle, // legend 모양 사각형
          legendPosition: LegendPosition.bottom, // legnd 위치설정
          showLegendsInRow: true, // 범주 row로 해주기
          legendTextStyle: TextStyle(
            fontSize: 15,
          ),
        ),
        gradientList: gradientList, // 그라데이션 리스트 값으로 불러와서 주기
      ),
    );
  }

  void reuslt()async{
  await Tcontroller.resultPercent;
  setState(() {}); // 화면을 다시 그림
  }
}
