import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SpinKitThreeInOut(
            // 사용할 로딩바 스타일을 선택하세요
            color: Theme.of(context).colorScheme.secondary, // 로딩바 색상 설정
            size: 50.0, // 로딩바 크기 설정
          ),
          // SizedBox(height: 16),
          // Text(
          //   "로딩 중...", // 로딩 중 텍스트 대신 원하는 다른 텍스트를 보여줄 수 있습니다.
          //   style: TextStyle(
          //     fontSize: 16,
          //     fontWeight: FontWeight.bold,
          //   ),
          // ),
        ],
      ),
    );
  }
}
