import 'package:flutter/material.dart';

class AiTestView extends StatefulWidget {
  const AiTestView({super.key});

  @override
  State<AiTestView> createState() => _AiTestViewState();
}

class _AiTestViewState extends State<AiTestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('data')
          ],
        ),
      ),
    );
  }
}