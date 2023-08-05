import 'package:flutter/material.dart';

import '../vm/loginCtrl.dart';

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
    final TextEditingController textController = isPassword
        ? controller.passwordController
        : controller.idController;

    return TextFormField(
      controller: textController,
      decoration: InputDecoration(labelText: labelText),
      obscureText: isPassword,
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please fill in this field';
        }
        return null;
      },
    );
  }
}