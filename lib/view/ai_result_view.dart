import 'package:flutter/material.dart';
import 'package:season3_team1_mainproject/components/ai_result_widget.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import 'package:http/http.dart' as http;

class AiResultView extends StatelessWidget {
  const AiResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('결과 보여주기'),
            AiResultWidget(),
          ],
        ),
      ),
    );
  }
  // --- Functions ---

  // getJSONData(){
  //   getJSONData() async {
  //   var url = Uri.parse(
  //     'http://localhost:8080/Rserve/response_iris.jsp?sepalLength=$sepalLength&sepalWidth=$sepalWidth&petalLength=$petalLength&petalWidth=$petalWidth'
  //   );
  //   var response = await http.get(url);
  //   var dataConvertedJSON = json.decode(utf8.decode(response.bodyBytes));
  //   result = dataConvertedJSON['result'];
  //   setState(() {
      
  //   });
  //   _showDialog();
  // }

  // _showDialog(){
  //   showDialog(
  //     context: context, 
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('품종 예측 결과'),
  //         content: Text('입력하신 품종은 $result 입니다.'),
  //       );
  //     },);
      
  // }

  // }

} // End