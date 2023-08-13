// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_state_manager/src/simple/get_state.dart';

// import '../vm/ai_test_controller.dart';

// class AiJobSelectSamuWidget extends StatefulWidget {
//   const AiJobSelectSamuWidget({super.key});

//   @override
//   State<AiJobSelectSamuWidget> createState() => _AiJobSelectSamuWidgetState();
// }

// class _AiJobSelectSamuWidgetState extends State<AiJobSelectSamuWidget> {
//   List<String> jobList = ["경영·행정·사무직"];
//   int listCount = 0; // 초기값을 -1로 설정

//   final AiTestController controller = Get.put(AiTestController());

//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<AiTestController>(
//       builder: (controller) {
//         return Center(
//           child: Column(
//             children: [
//               const Text(".\n.\n"),
//               SizedBox(
//                 height: 250,
//                 width: 300,
//                 child: ListView.builder(
//                   itemCount: jobList.length,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: GestureDetector(
//                         onTap: () {
//                           listCount = index;
//                           controller.selectJob = jobList[index];
//                           setState(() {});
//                         },
//                         child: SizedBox(
//                           height: 42,
//                           child: Card(
//                             color: index == listCount
//                                 ? Colors.grey
//                                 : Theme.of(context).cardColor,
//                             child: Column(
//                               children: [
//                                 Text(
//                                   jobList[index],
//                                   style: const TextStyle(
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
