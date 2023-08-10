import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:season3_team1_mainproject/model/ai_address_model.dart';

import '../model/aiTestModel.dart';

class AiResultWidget extends StatefulWidget {
  AiResultWidget({super.key});

  @override
  State<AiResultWidget> createState() => _AiResultWidgetState();
}

class _AiResultWidgetState extends State<AiResultWidget> {
  // Property
  String result = "";

  bool age_20 = false; // 20대
  bool age_30 = false; // 30대
  bool age_40 = false; // 40대
  bool age_50 = false; // 50대
  bool age_60 = false; // 60대
  bool age_70 = false; // 70대
  bool visual_impairmen_mild = false; // 시각장애 경증
  bool visual_impairmen_severe = false; // 시각장애 중증
  bool physical_disability_mild = false; // 지체장애 경증
  bool physical_disability_severe = false; // 지체장애 중증
  bool intellectual_disability_mild = false; // 지적장애 경증
  bool intellectual_disability_severe = false; // 지적장애 중증
  bool auditory_disorder_mild = false; // 청각장애 경증
  bool auditory_disorder_severe = false; // 청각장애 중증
  bool mental_disorder_mild = false; // 정신장애 경증
  bool mental_disorder_severe = false; // 정신장애 중증
  bool gyeongbuk = false; // 경북
  bool gangwon = false; // 강원
  bool jeonnam = false; // 전남
  bool chungbuk = false; // 충북
  bool gyenggi = false; // 경기
  bool incheon = false; // 인천
  bool seoul = false; // 서울
  bool ulsan = false; // 울산
  bool daejeon = false; // 대전
  bool busan = false; // 부산
  bool jeonbuk = false; // 전북
  bool gwangju = false; // 광주
  bool chungnam = false; // 충남
  bool daegu = false; // 대구
  bool gyengnam = false; // 경남
  bool jeju = false; // 제주
  bool sejong = false; // 세종
  bool jan = false; // 1월
  bool feb = false; // 2월
  bool mar = false; // 3월
  bool apr = false; // 4월
  bool may = false; // 5월
  bool jun = false; // 6월
  bool jul = false; // 7월
  bool aug = false; // 8월
  bool sep = false; // 9월
  bool oct = false; // 10월
  bool nov = false; // 11월
  bool dec = false; // 12월


  final AiTestController aiController = Get.find();
  final AddressController addressController = Get.find();

  
  @override
  void initState() {
    super.initState();
    getJSONData();
  }
  

  @override
  Widget build(BuildContext context) {
    int selectedSex = aiController.sexSelected.value;
    String address = "${addressController.address_result} ${addressController.subAddress_result} ${addressController.subAddresses1_result}";


  // if(aiController.age.value >= 20 && aiController.age.value < 30){
  //   age_20 = true;
  // }else if(aiController.age.value >= 30 && aiController.age.value < 40){
  //   age_30 = true;
  // }else if(aiController.age.value >= 40 && aiController.age.value < 50){
  //   age_40 = true;
  // }else if(aiController.age.value >= 50 && aiController.age.value < 60){
  //   age_50 = true;
  // }else if(aiController.age.value >= 30 && aiController.age.value < 40){
  //   age_60 = true;
  // }else{
  //   age_70 = true;
  // }

  switch (aiController.age.value) {
  case >= 20 && < 30:
    age_20 = true;
    break;
  case >= 30 && < 40:
    age_30 = true;
    break;
  case >= 40 && < 50:
    age_40 = true;
    break;
  case >= 50 && < 60:
    age_50 = true;
    break;
  case >= 60 && < 70:
    age_60 = true;
    break;
  default:
    age_70 = true;
}

  if(aiController.radioDisabledSelect == 1 && aiController.disabledSelect == "시각장애"){
    visual_impairmen_mild = true;
  }else if(aiController.radioDisabledSelect == 0 && aiController.disabledSelect == "시각장애"){
    visual_impairmen_severe = true;
  }else if (aiController.radioDisabledSelect == 1 && aiController.disabledSelect == "지체장애"){
    physical_disability_mild = true;
  } else if(aiController.radioDisabledSelect == 0 && aiController.disabledSelect == "지체장애"){
    physical_disability_severe = true;
  } else if(aiController.radioDisabledSelect == 1 && aiController.disabledSelect == "지적장애"){
    intellectual_disability_mild = true;
  } else if(aiController.radioDisabledSelect == 0 && aiController.disabledSelect == "지적장애"){
    intellectual_disability_severe = true;
  }else if(aiController.radioDisabledSelect == 1 && aiController.disabledSelect == "청각장애"){
    auditory_disorder_mild = true;
  }else if(aiController.radioDisabledSelect == 0 && aiController.disabledSelect == "청각장애"){
    auditory_disorder_severe = true;
  } else if(aiController.radioDisabledSelect == 1 && aiController.disabledSelect == "정신장애"){
    intellectual_disability_mild = true;
  } else if(aiController.radioDisabledSelect == 0 && aiController.disabledSelect == "정신장애"){
    intellectual_disability_severe = true;
  }





    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              Text('당신이 합격할 확률은 ${selectedSex == 1 ? '남성' : '여성'} %입니다.'),
              Text(aiController.age.value.toString()),
              Text('${aiController.disabledSelect}'),
              Text('${aiController.radioDisabledSelect == 1 ? '경증' : '중증'}'),
              Text('${aiController.employMonth}'),
              Text('${aiController.selectJob}'),
              Text('당신이 선택한 주소는$address'),
            ],
          ),
        );
      },
    );
  }

  getJSONData() async {

    // if(aiController.age.value =)


    var url = Uri.parse(
        "http://localhost:8080/Rserve/response_phase1.jsp?age_20=$age_20&age_30=$age_30&age_40=$age_40&age_50=$age_50&age_60=$age_60&age_70=$age_70&"
        "visualImpairment_Severe=$visual_impairmen_severe&visualImpairment_Mild=$visual_impairmen_mild&"
        "physicalImpairment_Mild=$physical_disability_mild&physicalImpairment_Severe=$physical_disability_severe&"
        "intellectualImpairment_Mild=$intellectual_disability_mild&intellectualImpairment_Severe=$intellectual_disability_severe&"
        "hearingImpairment_Mild=$auditory_disorder_mild&hearingImpairment_Severe=$auditory_disorder_severe&"
        "mentalDisorder_Mild=$mental_disorder_mild&mentalDisorder_Severe=$mental_disorder_severe&"
        "Gyeongbuk=$gyeongbuk&Gangwon=$gangwon&Jeonnam=$jeonnam&Chungbuk=$chungbuk&"
        "Gyeonggi=$gyenggi&Incheon=$incheon&Seoul=$seoul&Ulsan=$ulsan&Daejeon=$daejeon&"
        "Busan=$busan&Jeonbuk=$jeonbuk&Gwangju=$gwangju&Chungnam=$chungnam&"
        "Daegu=$daegu&Gyeongnam=$gyengnam&Jeju=$jeju&Sejong=$sejong&"
        "Jan=$jan&Feb=$feb&Mar=$mar&Apr=$apr&May=$may&Jun=$jun&Jul=$jul&Aug=$aug&Sep=$sep&Oct=$oct&Nov=$nov&Dec=$dec");
    var response = await http.get(url);
    print(response);
    var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
    result = dataConvertedJSON['result'];
    setState(() {});
    _showDialog();
  }

  _showDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('품종 예측 결과'),
          content: Text('입력하신 품종은 $result 입니다.'),
        );
      },
    );
  }
}

// End