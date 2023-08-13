import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:season3_team1_mainproject/vm/ai_address_controller.dart';
import 'package:season3_team1_mainproject/util/api_endpoint.dart';
import 'package:season3_team1_mainproject/vm/login_ctrl.dart';

import '../vm/ai_test_controller.dart';

class AiResultWidget extends StatefulWidget {
  const AiResultWidget({super.key});

  @override
  State<AiResultWidget> createState() => _AiResultWidgetState();
}

class _AiResultWidgetState extends State<AiResultWidget> {
  // Property

  final AiTestController controller =
      Get.put(AiTestController()); // 액션 없으면 어사인 부분만 안해주면됨

  String result = "";
  String result1 = "";
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

  final AiTestController aiController = Get.find();
  final AddressController addressController = Get.find();

  @override
  void initState() {
    super.initState();
    getJSONData();
    // range();
  }

  @override
  Widget build(BuildContext context) {
    int selectedSex = aiController.sexSelected.value;
    String address =
        "${addressController.address_result} ${addressController.subAddress_result} ${addressController.subAddresses1_result}";

    var resultText = resultPercentList.isEmpty
        ? resultPercent
        : resultPercentList.join(", ");

    final LoginController loginController = Get.find();

    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              // Text('당신이 합격할 확률은 ${selectedSex == 1 ? '남성' : '여성'} %입니다.'),
              Text("당신의 나이는 ${aiController.age.value.toString()}"),
              Text("당신의 장애유형은 ${aiController.disabledSelect}"),
              Text('${aiController.radioDisabledSelect == 1 ? '경증' : '중증'}'),
              Text('당신의 희망 취업일은 ${aiController.employMonth} 월'),
              Text('당신이 고른 직업은 ${aiController.selectJob}'),
              Text('당신이 선택한 주소는$address'),
              // Text("$age_20 $may $intellectual_disability_mild $incheon"),

              Text(
                "${loginController.userName ?? '당신의'}님의",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                "${aiController.selectJob} 합격 예상률은 $resultText %입니다!",
                style: const TextStyle(fontSize: 18),
              ),
              // resultText
              // 20대 2월 지적장애_경증 제주도
              // 넘어간거: 나이, 지역
            ],
          ),
        );
      },
    );
  }

  getJSONData() async {
    String baseUrl = ApiEndPoints.localhost + ApiEndPoints.apiEndPoints.ai_test;
    int ai_phase = 0;

    // range();

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

    print(
        "변환된 경증 중증 ${aiController.radioDisabledSelect} 변환된 장애 ${aiController.disabledSelect}");
    switch (aiController.radioDisabledSelect) {
      case 1:
        switch (aiController.disabledSelect) {
          case "시각장애":
            visual_impairmen_mild = "TRUE";
            break;
          case "지체장애":
            physical_disability_mild = "TRUE";
            break;
          case "지적장애":
            intellectual_disability_mild = "TRUE";
            break;
          case "청각장애":
            auditory_disorder_mild = "TRUE";
            break;
          case "정신장애":
            intellectual_disability_mild = "TRUE";
            break;
        }
        break;
      case 0:
        switch (aiController.disabledSelect) {
          case "시각장애":
            visual_impairmen_severe = "TRUE";
            break;
          case "지체장애":
            physical_disability_severe = "TRUE";
            break;
          case "지적장애":
            intellectual_disability_severe = "TRUE";
            break;
          case "청각장애":
            auditory_disorder_severe = "TRUE";
            break;
          case "정신장애":
            intellectual_disability_severe = "TRUE";
            break;
        }
        break;
    }

    switch (addressController.address_result) {
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
        ai_phase = 1;
        break;
      case "간호·보건 및 돌봄 서비스 관련 직군" || "전문·생산 및 정비 관련 직군" || "제조 단순직":
        ai_phase = 2;
        break;
      case "서비스 및 판매 관련 직군" || "청소 및 기타 개인서비스직":
        ai_phase = 3;
        break;
      case "돌봄 서비스직(간병·육아)" || "보건·의료직" || "사회복지·종교직":
        ai_phase = 4;
        break;
      case "건설·채굴직" ||
            "관리직(임원·부서장)" ||
            "교육직" ||
            "기계 설치·정비·생산직" ||
            "섬유·의복 생산직" ||
            "식품 가공·생산직" ||
            "예술·디자인·방송직" ||
            "운전·운송직" ||
            "인쇄·목재·공예 및 기타 설치·정비·생산직" ||
            "전기·전자 설치·정비·생산직":
        ai_phase = 5;
        break;
      case "경호·경비·스포츠·레크리에이션직" || "영업·미용·예식 서비스직" || "음식 서비스직":
        ai_phase = 6;
        break;
      default:
        break;
    }

    String requestUrl =
        "${baseUrl}?ai=$ai_phase&age_20=$age_20&age_30=$age_30&age_40=$age_40&age_50=$age_50&age_60=$age_60&age_70=$age_70&"
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

    // try {
    //   var response = await GetConnect().get(requestUrl);
    //   if (response.isOk) {
    //     result = response.body['message'][0];
    //     print(double.parse(result));
    //     resultPercent = double.parse(result) * 100;
    //     setState(() {});
    //     print("결과는 $result");
    //     return true;
    //   } else {
    //     print("실패");
    //     return false;
    //   }
    // } catch (e) {
    //   print(e);
    //   return false;
    // }
    print(requestUrl);

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
          resultPercentList.add(message);
        }
      } else if (message2 != null) {
        resultPercentList.add(message2);
      }

      setState(() {});
    } else {
      print("실패");
    }

    // var response = await GetConnect().get(requestUrl);
    // if (response.isOk) {
    //   // print(messages);
    //   var messages = response.body['message'];
    //   var messages1 = response.body['message'][0];

    //   if (messages is List) {
    //     for (var message in messages) {
    //       var result = double.parse(message);
    //       var resultPercent = (result * 100).toStringAsFixed(2);
    //       resultPercentList.add(resultPercent);
    //     }
    //   } else if (messages1 != null) {
    //     // 결과값이 리스트 형태가 아니라면 단일 값으로 처리
    //     var result = double.parse(messages1);
    //     var resultPercent = (result * 100).toStringAsFixed(2);
    //     resultPercentList.add(resultPercent);
    //   }
    //   print(resultPercentList);

    //   setState(() {});
    // } else {
    //   print("실패");
    // }
  }
}


// }// End






    // var url = Uri.parse(
    //     "http://localhost:8080/Rserve/response_phase1.jsp?age_20=$age_20&age_30=$age_30&age_40=$age_40&age_50=$age_50&age_60=$age_60&age_70=$age_70&"
    //     "visualImpairment_Severe=$visual_impairmen_severe&visualImpairment_Mild=$visual_impairmen_mild&"
    //     "physicalImpairment_Mild=$physical_disability_mild&physicalImpairment_Severe=$physical_disability_severe&"
    //     "intellectualImpairment_Mild=$intellectual_disability_mild&intellectualImpairment_Severe=$intellectual_disability_severe&"
    //     "hearingImpairment_Mild=$auditory_disorder_mild&hearingImpairment_Severe=$auditory_disorder_severe&"
    //     "mentalDisorder_Mild=$mental_disorder_mild&mentalDisorder_Severe=$mental_disorder_severe&"
    //     "Gyeongbuk=$gyeongbuk&Gangwon=$gangwon&Jeonnam=$jeonnam&Chungbuk=$chungbuk&"
    //     "Gyeonggi=$gyenggi&Incheon=$incheon&Seoul=$seoul&Ulsan=$ulsan&Daejeon=$daejeon&"
    //     "Busan=$busan&Jeonbuk=$jeonbuk&Gwangju=$gwangju&Chungnam=$chungnam&"
    //     "Daegu=$daegu&Gyeongnam=$gyengnam&Jeju=$jeju&Sejong=$sejong&"
    //     "Jan=$jan&Feb=$feb&Mar=$mar&Apr=$apr&May=$may&Jun=$jun&Jul=$jul&Aug=$aug&Sep=$sep&Oct=$oct&Nov=$nov&Dec=$dec");
    // var response = await http.get(url);
    // print(response);
    // try {
    //   var response = await GetConnect().get(requestUrl);
    //   if (response.isOk) {
    //     result = response.body['message'][0];
    //     print(double.parse(result));
    //     resultPercent = double.parse(result) * 100;
    //     setState(() {});
    //     print("결과는 $result");
    //     return true;
    //   } else {
    //     print("좇됨");
    //     return false;
    //   }
    // } catch (e) {
    //   print(e);
    //   return false;
    // }

    // _showDialog();

  // _showDialog() {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('품종 예측 결과'),
  //         content: Text('입력하신 품종은 $result 입니다.'),
  //       );
  //     },
  //   );
  // }


