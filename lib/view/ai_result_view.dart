import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:season3_team1_mainproject/components/ai_result_widget.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';
import 'package:http/http.dart' as http;

import '../vm/ai_address_controller.dart';
import '../vm/ai_test_controller.dart';
import 'home.dart';

class AiResultView extends StatelessWidget {
  const AiResultView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => AddressController());
    final AddressController controller = Get.put(AddressController());

    return Scaffold(
      appBar: const MyAppBar(),
      body: GetBuilder<AiTestController>(
        builder: (controller) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 400,
                  height: 500,
                  child: AiResultWidget(),
                  ),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(
                      const Home(),
                      transition: Transition.noTransition,
                    );
                  },
                  child: const Text('홈으로'),
                ),
              ],
            ),
          );
        },
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
