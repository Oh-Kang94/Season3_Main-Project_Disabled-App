import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;

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

  @override
  void initState() {
    super.initState();
    getJSONData();
  }
  

  @override
  Widget build(BuildContext context) {
    int selectedSex = aiController.sexSelected.value;

  
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
            ],
          ),
        );
      },
    );
  }

  getJSONData() async {
    var url = Uri.parse(
        "http://localhost:8080/Rserve/response_phase1.jsp?age_20=$age_20&age_30=$age_30&age_40=$age_40&age_50=$age_50&age_60=$age_60&age_70=$age_70&"
        "시각장애_중증=$visual_impairmen_mild&시각장애_경증=$visual_impairmen_severe&"
        "지체장애_경증=$physical_disability_mild&지체장애_중증=$physical_disability_severe&"
        "지적장애_경증=$intellectual_disability_mild&지적장애_중증=$intellectual_disability_severe&"
        "청각장애_경증=$auditory_disorder_mild&청각장애_중증=$auditory_disorder_severe&"
        "정신장애_경증=$mental_disorder_mild&정신장애_중증=$mental_disorder_severe&"
        "경북=$gyeongbuk&강원=$gangwon&전남=$jeonnam&충북=$chungbuk&"
        "경기=$gyenggi&인천=$incheon&서울=$seoul&울산=$ulsan&대전=$daejeon&"
        "부산=$busan&전북=$jeonbuk&광주=$gwangju&충남=$chungnam&"
        "대구=$daegu&경남=$gyengnam&제주=$jeju&세종=$sejong&"
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