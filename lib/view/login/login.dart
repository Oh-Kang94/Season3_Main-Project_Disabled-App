import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../../components/loginForm.dart';
import '../../vm/loginCtrl.dart';

class LoginUser extends StatelessWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<LoginController>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/lottieLogin.json'),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: controller.loginFormKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoginForm(controller: controller, labelText: 'E-mail',isPassword: false,),
                        LoginForm(controller: controller, labelText: 'Password', isPassword: true,),
                        ElevatedButton(
                          onPressed: controller.login,
                          child: const Text('Login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


