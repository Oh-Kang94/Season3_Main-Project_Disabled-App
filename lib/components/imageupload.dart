import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImageUploadWidget extends StatelessWidget {
  final Rx<File?> _image = Rx(null); // 선택된 이미지를 저장하는 변수 (Rx로 상태 관리)
  final Rx<String?> _imageUrl =
      Rx(null); // Firebase Storage에 업로드된 이미지의 다운로드 URL을 저장하는 변수 (Rx로 상태 관리)

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Obx(() {
          if (_image.value != null) {
            return Image.file(_image.value!); // 선택된 이미지를 표시
          } else {
            return SizedBox.shrink();  // 이미지 선택 전 플레이스홀더 표시
          }
        }),
        ElevatedButton(
          onPressed: pickImage, // 갤러리에서 이미지 선택
          child: Text('이미지 선택'),
        ),
        ElevatedButton(
          onPressed: uploadImage, // 이미지 업로드
          child: Text('이미지 업로드'),
        ),
        Obx(() {
          if (_imageUrl.value != null) {
            return Text('이미지 URL: ${_imageUrl.value}'); // 업로드된 이미지의 URL 표시
          } else {
            return const SizedBox.shrink(); // URL이 없을 경우 보이지 않도록 처리
          }
        }),
      ],
    );
  }

  // 갤러리에서 이미지 선택하는 메서드
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      _image.value = File(pickedImage.path);
    }
  }

  // 이미지를 Firebase Storage에 업로드하는 메서드
  Future<void> uploadImage() async {
    if (_image.value == null) {
      return;
    }

    try {
      final storage = FirebaseStorage.instance;
      final ref = storage.ref().child('images/${DateTime.now()}.png');
      await ref.putFile(_image.value!);
      final downloadUrl = await ref.getDownloadURL();

      _imageUrl.value = downloadUrl;
    } catch (e) {
      print('이미지 업로드 오류: $e');
    }
  }

}
