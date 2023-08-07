import 'package:flutter/material.dart';

class AiLocationWidget extends StatefulWidget {
  const AiLocationWidget({super.key});

  @override
  State<AiLocationWidget> createState() => _AiLocationWidgetState();
}

class _AiLocationWidgetState extends State<AiLocationWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('방식 고민 후 추가 예정'),
          const Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
