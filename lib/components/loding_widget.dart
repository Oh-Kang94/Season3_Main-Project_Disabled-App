// import 'package:flutter/material.dart';

// class LoadingDialog extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: CircularProgressIndicator(), // 로딩 애니메이션으로는 CircularProgressIndicator를 사용합니다.
//     );
//   }
// }


// import 'package:flutter/material.dart';

// class LoadingDialog extends StatefulWidget {
//   @override
//   _LoadingDialogState createState() => _LoadingDialogState();
// }

// class _LoadingDialogState extends State<LoadingDialog> with SingleTickerProviderStateMixin {
//   late AnimationController _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(vsync: this, duration: Duration(seconds: 1))
//       ..repeat(); // 로딩바 애니메이션을 반복하도록 설정합니다.
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: AnimatedBuilder(
//         animation: _animationController,
//         builder: (context, child) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               CircularProgressIndicator(
//                 value: _animationController.value, // 로딩바 애니메이션의 진행 상태에 따라 진행됩니다.
//               ),
//               SizedBox(height: 16),
//               Text(
//                 "로딩 중...", // 로딩 중 텍스트 대신 원하는 다른 텍스트를 보여줄 수 있습니다.
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitFadingCircle(  // 사용할 로딩바 스타일을 선택하세요
            color: Colors.blue,  // 로딩바 색상 설정
            size: 50.0,          // 로딩바 크기 설정
          ),
          SizedBox(height: 16),
          Text(
            "로딩 중...",   // 로딩 중 텍스트 대신 원하는 다른 텍스트를 보여줄 수 있습니다.
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
