// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/util/api_endpoint.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../view/home.dart';
import '../../vm/ai_test/ai_address_controller.dart';
import '../../vm/ai_test/ai_test_controller.dart';


class AiResultWidget extends StatefulWidget {
  const AiResultWidget({super.key});

  @override
  State<AiResultWidget> createState() => _AiResultWidgetState();
}

final AiTestController _tController =
    Get.put(AiTestController()); // 액션 없으면 어사인 부분만 안해주면됨
final AiTestController aiController = Get.find();
final AddressController addressController = Get.find();

class _AiResultWidgetState extends State<AiResultWidget> {
  // Property

  String result = "";
  String resultJob = "";
  List<String> resultJobList = [];
  List<String> resultPercentList = [];
  double resultPercent = 0.0;

  String age_20 = "FALSE"; // 20대
  String age_30 = "FALSE"; // 30대
  String age_40 = "FALSE"; // 40대
  String age_50 = "FALSE"; // 50대
  String age_60 = "FALSE"; // 60대
  String age_70 = "FALSE"; // 70대
  String visual_impairmen_mild = "FALSE"; // 시각장애 경증
  String visual_impairmen_severe = "FALSE"; // 시각장애 중증
  String physical_disability_mild = "FALSE"; // 지체장애 경증
  String physical_disability_severe = "FALSE"; // 지체장애 중증
  String intellectual_disability_mild = "FALSE"; // 지적장애 경증
  String intellectual_disability_severe = "FALSE"; // 지적장애 중증
  String auditory_disorder_mild = "FALSE"; // 청각장애 경증
  String auditory_disorder_severe = "FALSE"; // 청각장애 중증
  String mental_disorder_mild = "FALSE"; // 정신장애 경증
  String mental_disorder_severe = "FALSE"; // 정신장애 중증
  String gyeongbuk = "FALSE"; // 경북
  String gangwon = "FALSE"; // 강원
  String jeonnam = "FALSE"; // 전남
  String chungbuk = "FALSE"; // 충북
  String gyenggi = "FALSE"; // 경기
  String incheon = "FALSE"; // 인천
  String seoul = "FALSE"; // 서울
  String ulsan = "FALSE"; // 울산
  String daejeon = "FALSE"; // 대전
  String busan = "FALSE"; // 부산
  String jeonbuk = "FALSE"; // 전북
  String gwangju = "FALSE"; // 광주
  String chungnam = "FALSE"; // 충남
  String daegu = "FALSE"; // 대구
  String gyengnam = "FALSE"; // 경남
  String jeju = "FALSE"; // 제주
  String sejong = "FALSE"; // 세종
  String jan = "FALSE"; // 1월
  String feb = "FALSE"; // 2월
  String mar = "FALSE"; // 3월
  String apr = "FALSE"; // 4월
  String may = "FALSE"; // 5월
  String jun = "FALSE"; // 6월
  String jul = "FALSE"; // 7월
  String aug = "FALSE"; // 8월
  String sep = "FALSE"; // 9월
  String oct = "FALSE"; // 10월
  String nov = "FALSE"; // 11월
  String dec = "FALSE"; // 12월

  late Map<String, double> dataMap;
  List<Color> colorsList = [
    const Color(0xffD95AF3),
    const Color.fromARGB(255, 55, 100, 64),
    const Color.fromARGB(255, 79, 123, 228),
    const Color.fromARGB(255, 150, 153, 40),
    const Color.fromARGB(255, 36, 60, 74),
    const Color.fromARGB(255, 241, 255, 134),
    const Color.fromARGB(200, 255, 120, 60),
    const Color.fromARGB(255, 232, 141, 255),
    const Color.fromARGB(120, 200, 120, 200),
    const Color.fromARGB(255, 255, 80, 80),
  ];

  final gradientList = <List<Color>>[
    [
      const Color.fromRGBO(223, 250, 92, 1),
      const Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      const Color.fromRGBO(129, 182, 205, 1),
      const Color.fromRGBO(91, 253, 199, 1),
    ],
    [
      const Color.fromRGBO(175, 63, 62, 1),
      const Color.fromRGBO(254, 154, 92, 1),
    ],
  ];

  late Future<void> jsonDataFuture;
  bool isLoading = true;
  int resultIndex = 0;

  @override
  void initState() {
    super.initState();
    dataMap = {
      "경영행정사무직": 18.47,
      "기타": 4.25,
      "서비스직": 17.70,
      "Cosmetics": 3.51,
      "Other": 2.83,
    };
    // 3초 동안 로딩 표시 후 데이터 로딩 시작
    Future.delayed(const Duration(seconds: 3), () async {
      await getJSONData(); // 데이터 로딩 시작
      setState(() {
        isLoading = false; // 로딩 상태 변경
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    var resultText = resultPercentList.isEmpty
        ? resultPercent
        : resultPercentList.join(", ");

    var resultJobText =
        resultJobList.isEmpty ? resultJob : resultJobList.join(", ");

    String selectedJob = _tController.selectJob;
    List<String> resultTextList = resultText.toString().split(", ");

    if (selectedJob == "경영·행정·사무직" && resultPercentList.length >= 3) {
      dataMap = {
        "경영·행정·사무직": double.parse(resultPercentList[0]),
        "기타": double.parse(resultPercentList[1]),
        "서비스직": double.parse(resultPercentList[2])
      };
    } else if (selectedJob == "제조 단순직" && resultTextList.length >= 3) {
      dataMap = {
        "간호·보건 및 돌봄 서비스 관련 직군": double.parse(resultTextList[0]),
        "전문·생산 및 정비 관련 직군": double.parse(resultTextList[1]),
        "제조 단순직": double.parse(resultTextList[2]),
      };
    } else if (selectedJob == "청소 및 기타 개인서비스직" && resultTextList.length >= 2) {
      dataMap = {
        "서비스 및 판매 관련 직군": double.parse(resultTextList[0]),
        "청소 및 기타 개인서비스직": double.parse(resultTextList[1]),
      };
    } else if (selectedJob == "간호·보건 및 돌봄 서비스 관련 직군" &&
        resultTextList.length >= 3) {
      dataMap = {
        "돌봄 서비스직(간병·육아)": double.parse(resultTextList[0]),
        "보건·의료직": double.parse(resultTextList[1]),
        "사회복지·종교직": double.parse(resultTextList[2]),
      };
    } else if (selectedJob == "전문·생산 및 정비 관련 직군" &&
        resultTextList.length >= 10) {
      dataMap = {
        "건설·채굴직": double.parse(resultTextList[0]),
        "관리직(임원·부서장)": double.parse(resultTextList[1]),
        "교육직": double.parse(resultTextList[2]),
        "기계 설치·정비·생산직": double.parse(resultTextList[3]),
        "섬유·의복 생산직": double.parse(resultTextList[4]),
        "식품 가공·생산직": double.parse(resultTextList[5]),
        "예술·디자인·방송직": double.parse(resultTextList[6]),
        "운전·운송직": double.parse(resultTextList[7]),
        "인쇄·목재·공예 및 기타 설치·정비·생산직": double.parse(resultTextList[8]),
        "전기·전자 설치·정비·생산직": double.parse(resultTextList[9]),
      };
    } else if (selectedJob == "서비스 및 판매 관련 직군" && resultTextList.length >= 3) {
      dataMap = {
        "경호·경비·스포츠·레크리에이션직": double.parse(resultTextList[0]),
        "영업·미용·예식 서비스직": double.parse(resultTextList[1]),
        "음식 서비스직": double.parse(resultTextList[2]),
      };
    }
    return GetBuilder<AiTestController>(
  builder: (controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: isLoading
              ? SizedBox(
                height: 690.h,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                  ],
                ),) // 로딩 중일 때는 로딩 바 표시
              : SingleChildScrollView(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Text(
                          controller.userData?.name != null
                              ? '${controller.userData!.name}님의'
                              : '당신의',
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            '가장 높은 확률로 합격할 직업은',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          '$resultJobText 입니다!',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "비슷한 직업분류군의 예상 합격률입니다.",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 60,
                        ),
                        Container(
                          color: Theme.of(context).cardColor, // 선택되지 않은 항목의 색상
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: 600,
                            child: PieChart(
                              dataMap: dataMap,
                              colorList: colorsList,
                              chartRadius:
                                  MediaQuery.of(context).size.width / 1.5,
                              centerText: _tController.selectJob,
                              chartType: ChartType.ring,
                              ringStrokeWidth: 80,
                              animationDuration: const Duration(seconds: 3),
                              chartValuesOptions: const ChartValuesOptions(
                                showChartValues: true,
                                showChartValuesOutside: true,
                                showChartValuesInPercentage: true,
                                showChartValueBackground: true,
                                chartValueStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              legendOptions: const LegendOptions(
                                showLegends: true,
                                legendShape: BoxShape.circle,
                                legendPosition: LegendPosition.bottom,
                                showLegendsInRow: false,
                                legendTextStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.offAll(
                              const Home(),
                              transition: Transition.noTransition,
                            );
                          },
                          child: const Text(
                            '홈으로',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ],
    );
  },
);

  }


  Future<void> getJSONData() async {
    String baseUrl = ApiEndPoints.baseurl + ApiEndPoints.apiEndPoints.ai_test;
    int aiPhase = 0;

    if (aiController.age.value >= 20 && aiController.age.value < 30) {
      age_20 = "TRUE";
    } else if (aiController.age.value >= 30 && aiController.age.value < 40) {
      age_30 = "TRUE";
    } else if (aiController.age.value >= 40 && aiController.age.value < 50) {
      age_40 = "TRUE";
    } else if (aiController.age.value >= 50 && aiController.age.value < 60) {
      age_50 = "TRUE";
    } else if (aiController.age.value >= 60 && aiController.age.value < 70) {
      age_60 = "TRUE";
    } else {
      age_70 = "TRUE";
    }
    switch (aiController.radioDisabledSelect) {
      case 1:
        switch (aiController.disabledSelect) {
          case "시각 장애":
            visual_impairmen_mild = "TRUE";
            break;
          case "지체 장애":
            physical_disability_mild = "TRUE";
            break;
          case "지적 장애":
            intellectual_disability_mild = "TRUE";
            break;
          case "청각 장애":
            auditory_disorder_mild = "TRUE";
            break;
          case "정신 장애":
            intellectual_disability_mild = "TRUE";
            break;
        }
        break;
      case 0:
        switch (aiController.disabledSelect) {
          case "시각 장애":
            visual_impairmen_severe = "TRUE";
            break;
          case "지체 장애":
            physical_disability_severe = "TRUE";
            break;
          case "지적 장애":
            intellectual_disability_severe = "TRUE";
            break;
          case "청각 장애":
            auditory_disorder_severe = "TRUE";
            break;
          case "정신 장애":
            intellectual_disability_severe = "TRUE";
            break;
        }
        break;
    }

    switch (addressController.addressResult) {
      case "경상북도":
        gyeongbuk = "TRUE";
        break;
      case "강원도":
        gangwon = "TRUE";
        break;
      case "전라남도":
        jeonnam = "TRUE";
        break;
      case "경기도":
        gyenggi = "TRUE";
        break;
      case "충청북도":
        chungbuk = "TRUE";
        break;
      case "인천광역시":
        incheon = "TRUE";
        break;
      case "서울특별시":
        seoul = "TRUE";
        break;
      case "울산광역시":
        ulsan = "TRUE";
        break;
      case "대전광역시":
        daejeon = "TRUE";
        break;
      case "부산광역시":
        busan = "TRUE";
        break;
      case "전라북도":
        jeonbuk = "TRUE";
        break;
      case "광주광역시":
        gwangju = "TRUE";
        break;
      case "충청남도":
        chungnam = "TRUE";
        break;
      case "대구광역시":
        daegu = "TRUE";
        break;
      case "경상남도":
        gyengnam = "TRUE";
        break;
      case "제주특별자치도":
        jeju = "TRUE";
        break;
      case "세종특별자치시":
        sejong = "TRUE";
        break;
    }

    switch (aiController.employMonth) {
      case "1":
        jan = "TRUE";
        break;
      case "2":
        feb = "TRUE";
        break;
      case "3":
        mar = "TRUE";
        break;
      case "4":
        apr = "TRUE";
        break;
      case "5":
        may = "TRUE";
        break;
      case "6":
        jun = "TRUE";
        break;
      case "7":
        jul = "TRUE";
        break;
      case "8":
        aug = "TRUE";
        break;
      case "9":
        sep = "TRUE";
        break;
      case "10":
        oct = "TRUE";
        break;
      case "11":
        nov = "TRUE";
        break;
      case "12":
        dec = "TRUE";
        break;
      default:
        break;
    }

    switch (aiController.selectJob) {
      case "경영·행정·사무직":
        aiPhase = 1;
        break;
      case "제조 단순직":
        aiPhase = 2;
        break;
      case "청소 및 기타 개인서비스직":
        aiPhase = 3;
        break;
      case "간호·보건 및 돌봄 서비스 관련 직군":
        aiPhase = 4;
        break;
      case "전문·생산 및 정비 관련 직군":
        aiPhase = 5;
        break;
      case "서비스 및 판매 관련 직군":
        aiPhase = 6;
        break;
      default:
        break;
    }

    String requestUrl =
        "$baseUrl?ai=$aiPhase&age_20=$age_20&age_30=$age_30&age_40=$age_40&age_50=$age_50&age_60=$age_60&age_70=$age_70&"
        "visualImpairment_Severe=$visual_impairmen_severe&visualImpairment_Mild=$visual_impairmen_mild&"
        "physicalImpairment_Mild=$physical_disability_mild&physicalImpairment_Severe=$physical_disability_severe&"
        "intellectualImpairment_Mild=$intellectual_disability_mild&intellectualImpairment_Severe=$intellectual_disability_severe&"
        "hearingImpairment_Mild=$auditory_disorder_mild&hearingImpairment_Severe=$auditory_disorder_severe&"
        "mentalDisorder_Mild=$mental_disorder_mild&mentalDisorder_Severe=$mental_disorder_severe&"
        "Gyeongbuk=$gyeongbuk&Gangwon=$gangwon&Jeonnam=$jeonnam&Chungbuk=$chungbuk&"
        "Gyeonggi=$gyenggi&Incheon=$incheon&Seoul=$seoul&Ulsan=$ulsan&Daejeon=$daejeon&"
        "Busan=$busan&Jeonbuk=$jeonbuk&Gwangju=$gwangju&Chungnam=$chungnam&"
        "Daegu=$daegu&Gyeongnam=$gyengnam&Jeju=$jeju&Sejong=$sejong&"
        "Jan=$jan&Feb=$feb&Mar=$mar&Apr=$apr&May=$may&Jun=$jun&Jul=$jul&Aug=$aug&Sep=$sep&Oct=$oct&Nov=$nov&Dec=$dec";


    var response = await GetConnect().get(requestUrl);
    if (response.isOk) {
      var responseData = response.body;
      var messages = responseData['message'];
      var message2 = responseData['message2'];

      if (messages is List) {
        for (var message in messages) {
          var result = double.tryParse(message);
          if (result != null) {
            var resultPercent = (result * 100).toStringAsFixed(2);
            resultPercentList.add(resultPercent);
          } else {
            resultPercentList.add(message);
          }
        }
      } else if (messages != null) {
        var result = double.tryParse(messages);
        if (result != null) {
          var resultPercent = (result * 100).toStringAsFixed(2);
          resultPercentList.add(resultPercent);
        } else {
          resultPercentList.add(messages);
        }
      }

      if (message2 is List) {
        for (var message in message2) {
          resultJobList.add(message);
        }
      } else if (message2 != null) {
        resultJobList.add(message2);
      }

      setState(() {});
    } else {
    }
  }
}

