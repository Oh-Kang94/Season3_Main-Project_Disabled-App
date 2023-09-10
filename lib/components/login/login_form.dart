import 'package:flutter/material.dart';

import '../../vm/login_ctrl.dart';
class LoginForm extends StatelessWidget {
  const LoginForm({
    super.key,
    required this.controller,
    required this.labelText,
    required this.isPassword,
  });

  final LoginController controller;
  final String labelText;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    final TextEditingController textController =
        isPassword ? controller.passwordController : controller.idController;

    return TextFormField(
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: textController,
      decoration: InputDecoration(labelText: labelText),
      obscureText: isPassword,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '내용을 적어주세요.';
        }
        return null;
      },
      textInputAction: TextInputAction.next,
    );
  }
}
