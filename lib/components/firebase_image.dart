import 'package:flutter/material.dart';

class FirebaseImageWidget extends StatelessWidget {
  final String imagePath;

  const FirebaseImageWidget({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return imagePath != "default"
        ? CircleAvatar(
            backgroundImage: NetworkImage(
              imagePath,
            ),
          )
        : const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user.png"));
  }
}
