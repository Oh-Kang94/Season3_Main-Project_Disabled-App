import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/ai_location_text_widget.dart';
import 'package:season3_team1_mainproject/model/ai_address_server_model.dart';

import '../vm/ai_address_controller.dart';
// import 'model/address.dart';

class AiLocationWidget extends StatelessWidget {
  const AiLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.find<AddressController>();

    return AlertDialog(
      title: const Text(
        '취업 희망지역',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      content: GetBuilder<AddressController>(
        builder: (controller) {
          return Column(
            children: [
              // const 금지
              const Row(
                children: [
                  AiLocationTextWidget(),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Obx(() {
                  if (controller.addresses.isEmpty) {
                    return Center(
                      child: SizedBox(
                        height: 690.h,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 130,
                          child: ListView.builder(
                            itemCount: controller.addresses.length,
                            itemBuilder: (context, index) {
                              final address = controller.addresses[index];
                              return ListTile(
                                tileColor: address.isSelected
                                    ? Colors.grey
                                    : Colors.transparent,
                                title: Text(
                                  address.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                onTap: () {
                                  controller.selectedAddress.value = address;
                                  controller.address_result111 = "";
                                  controller.subAddress_result111 = "";
                                  controller.subAddresses1_result = "";
                                  controller.loadSubAddresses(address.code);
                                  controller.address(address.name);
                                  controller.update();
                                  // 선택 상태 초기화 및 현재 타일 선택 상태 설정
                                  for (var item in controller.addresses) {
                                    item.isSelected = false;
                                  }
                                  address.isSelected = true;
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ListView.builder(
                            itemCount: controller.subAddresses.length,
                            itemBuilder: (context, index) {
                              final subAddress = controller.subAddresses[index];
                              return ListTile(
                                tileColor: subAddress.isSelected
                                    ? Colors.grey
                                    : Colors.transparent,
                                title: Text(
                                  subAddress.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onTap: () {
                                  controller.selectedAddress.value = subAddress;
                                  controller
                                      .loadSubAddressDetails(subAddress.code);
                                  controller.subAddressesR(subAddress.name);

                                  // 선택 상태 초기화 및 현재 타일 선택 상태 설정
                                  for (var item in controller.subAddresses) {
                                    item.isSelected = false;
                                  }
                                  subAddress.isSelected = true;
                                  controller.update();
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ListView.builder(
                            itemCount: controller.subAddresses1.length,
                            itemBuilder: (context, index) {
                              final subAddresses1 =
                                  controller.subAddresses1[index];
                              final bool lastIsSelected = subAddresses1 ==
                                  controller.selectedAddress.value;
                              return ListTile(
                                tileColor: lastIsSelected
                                    ? Colors.grey
                                    : Colors.transparent,
                                title: Text(
                                  subAddresses1.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onTap: () {
                                  controller.subAddresses1R(subAddresses1.name);
                                  controller.selectedAddress.value =
                                      subAddresses1;
                                  controller.update();
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    );
                  }
                }),
              ),
            ],
          );
        },
      ),
      actions: [
        TextButton(
          onPressed: () {
            controller.addressStatus = true;
            controller.update();
            Get.back();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
