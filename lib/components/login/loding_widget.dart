import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

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
        ],
      ),
    );
  }
}
