import 'package:flutter/material.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

class RegisterUser extends StatelessWidget {
  const RegisterUser({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: MyAppBar(),
        body: Center(),
      ),
    );
  }
}
