import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseImageWidget extends StatelessWidget {
  final String? imagePath;

  const FirebaseImageWidget({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return imagePath != "default"
        ? FutureBuilder(
            future: firebase_storage.FirebaseStorage.instance
                .ref(imagePath)
                .getDownloadURL(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return CircleAvatar(
                  child: Image.network(
                    snapshot.data.toString(),
                    fit: BoxFit.cover,
                  ),
                );
              } else if (snapshot.hasError) {
                return const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user.png"),
                );
              } else {
                return const CircleAvatar(
                  backgroundImage: AssetImage("assets/images/user.png"),
                );
              }
            },
          )
        : const CircleAvatar(
            backgroundImage: AssetImage("assets/images/user.png"));
  }
}
