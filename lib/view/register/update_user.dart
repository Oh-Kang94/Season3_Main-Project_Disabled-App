// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/logo_pic.dart';
import 'package:kpostal/kpostal.dart';
import 'package:season3_team1_mainproject/util/regex.dart';

import '../../components/firebase_image.dart';
import '../../vm/update_ctrl.dart';

class UpdateUser extends StatelessWidget {
  UpdateUser({super.key});
  final UpdateController updateController = Get.put(UpdateController());

  @override
  Widget build(BuildContext context) {
    updateController.onInit;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const LogoPic(isappbar: false),
                  SizedBox(height: 30.h),
                  const Text(
                    "회원 수정",
                    style:
                        TextStyle(fontFamily: "NotoSansKR-Bold", fontSize: 30),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                      key: updateController.updateFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: updateController.idController,
                            readOnly: true,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              labelText: 'ID',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.idpwRegExp.hasMatch(value)) {
                                return '영어 소문자와 숫자로만 이루어진 10글자 이하로 입력 가능합니다.';
                              }
                              return null;
                            },
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: updateController.passwordController,
                            obscureText: true,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: '비밀번호',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.idpwRegExp.hasMatch(value)) {
                                return '영어 소문자와 숫자로만 이루어진 10글자 이하로 입력 가능합니다.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: updateController.nameController,
                            textInputAction: TextInputAction.next,
                            decoration: const InputDecoration(
                              labelText: '이름',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.nameRegExp.hasMatch(value)) {
                                return '한글로만 이루어진 2글자 이상으로 입력 가능합니다.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            controller: updateController.emailController,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              labelText: '이메일',
                            ),
                            textInputAction: TextInputAction.next,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.emailRegExp.hasMatch(value)) {
                                return '올바른 이메일 주소를 입력해주세요.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            controller: updateController.phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                                labelText: '핸드폰', hintText: "'-'없이 입력하세요!"),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '내용을 적어주세요.';
                              }
                              if (!RegexForm.phoneRegExp.hasMatch(value)) {
                                return '11자리의 숫자로만 이루어진 핸드폰 번호를 입력해주세요.';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => TextFormField(
                              controller: updateController.genderController,
                              onTap: () async {
                                updateController.showGenderPicker(context);
                              },
                              validator: (value) {
                                if (value == "누르시면 성별이 검색됩니다.") {
                                  return '버튼을 눌러주세요.';
                                }
                                return null;
                              },
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                labelText: '성별',
                                hintText:
                                    updateController.selectedgender.value !=
                                            null
                                        ? updateController
                                            .selectedgender.value!.name
                                        : '누르시면 입력 가능합니다.',
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => TextFormField(
                              onTap: () async {
                                updateController.showBirthPicker(context);
                              },
                              controller: updateController.birthController,
                              readOnly: true,
                              validator: (value) {
                                if (value == "누르시면 생년월일이 검색됩니다.") {
                                  return '버튼을 눌러주세요.';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                labelText: '생년월일',
                                hintText: updateController
                                            .selectedBirth.value !=
                                        null
                                    ? "${updateController.selectedBirth.value?.year.toString()}-${updateController.selectedBirth.value?.month.toString()}-${updateController.selectedBirth.value?.day.toString()}"
                                    : '누르시면 입력 가능합니다.',
                              ),
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Obx(
                            () => TextFormField(
                              controller: updateController.disabledController,
                              onTap: () async {
                                updateController.showDisabilityPicker(context);
                              },
                              validator: (value) {
                                if (value == "장애 유형 선택") {
                                  return '버튼을 눌러주세요.';
                                }
                                return null;
                              },
                              readOnly: true,
                              keyboardType: TextInputType.none,
                              decoration: InputDecoration(
                                  labelText: '장애유형선택',
                                  hintText: updateController
                                              .selectedDisability.value !=
                                          null
                                      ? updateController
                                          .selectedDisability.value!.name
                                      : '누르시면 입력 가능합니다.'),
                            ),
                          ),
                          TextFormField(
                            onTap: () {
                              Get.to(
                                KpostalView(
                                  callback: (Kpostal result) {
                                    print(result.address);
                                    print(
                                        "경도: ${result.latitude} 위도: ${result.longitude}");
                                    updateController.setAddress(
                                        result.address,
                                        result.latitude!,
                                        result.longitude!); // 주소를 설정
                                  },
                                ),
                              );
                            },
                            validator: (value) {
                              if (value == "누르시면 주소가 검색됩니다.") {
                                return '버튼을 눌러주세요.';
                              }
                              return null;
                            },
                            readOnly: true,
                            controller: updateController.addressController,
                            decoration: const InputDecoration(
                              labelText: '주소',
                            ),
                          ),
                          SizedBox(height: 10.h),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("프로필 사진 설정"),
                              ]),
                          GestureDetector(
                            onTap: () => updateController.imagePicker(),
                            child: Obx(
                              () => updateController.pick.value == null
                                  ? FirebaseImageWidget(
                                      imagePath: updateController.path.value,
                                      size: 100.h)
                                  : CircleAvatar(
                                      radius: 100.h,
                                      backgroundImage: FileImage(File(
                                          updateController.pick.value!.path)),
                                    ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          ElevatedButton(
                            onPressed: () {
                              updateController.onSaved();
                            },
                            child: const Text('회원 수정'),
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
      ),
    );
  }
}
