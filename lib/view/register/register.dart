import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/view/appbar/myappbar.dart';

import '../../model/disabledModel.dart';
import '../../vm/registerCtrl.dart';

class RegisterUser extends StatelessWidget {
  RegisterUser({super.key});

  final RegisterationController registerationController =
      Get.put(RegisterationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: const MyAppBar(),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const Text("회원 가입"),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Form(
                    key: registerationController.registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextFormField(
                          controller: registerationController.idController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'ID',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller:
                              registerationController.passwordController,
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: '비밀번호',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: registerationController.nameController,
                          textInputAction: TextInputAction.next,
                          decoration: InputDecoration(
                            labelText: 'Name',
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: registerationController.emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            labelText: 'Email',
                          ),
                          textInputAction: TextInputAction.next,
                        ),
                        const SizedBox(height: 16),
                        TextFormField(
                          controller: registerationController.phoneController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Phone',
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("성별"),
                            Obx(
                              () => Switch(
                                value: registerationController.isSwitched.value,
                                onChanged: registerationController.toggleSwitch,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Text("장애 유형 선택"),
                            ElevatedButton(
                              onPressed: () {
                                showDisabilityPicker(context);
                              },
                              child: Obx(
                                () => Text(registerationController
                                        .selectedDisability.value?.name ??
                                    '장애 유형 선택'),
                              ),
                            ),
                          ],
                        ),
                        TextFormField(
                          controller: registerationController.addressController,
                          decoration: InputDecoration(
                            labelText: '주소',
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {},
                          child: const Text('회원가입'),
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

  Future<void> showDisabilityPicker(BuildContext context) async {
    DisabledModel? result = await showModalBottomSheet(
      context: context,
      builder: (context) {
        return SizedBox(
          height: 200,
          child: CupertinoPicker(
            itemExtent: 50,
            onSelectedItemChanged: (index) {
              registerationController
                  .setSelectedDisability(disabilities[index]);
            },
            children: disabilities
                .map((disability) => Text(disability.name))
                .toList(),
          ),
        );
      },
    );
    if (result != null) {
      print('선택한 장애 유형: ${result.name}');
    }
  }
}
