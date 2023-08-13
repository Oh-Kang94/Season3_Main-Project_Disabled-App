import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/components/ai_location_text_widget.dart';

import '../vm/ai_address_controller.dart';
// import 'model/address.dart';

class AiLocationWidget extends StatelessWidget {
  const AiLocationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AddressController _controller = Get.find<AddressController>();

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
              Row(
                children: [
                  AiLocationTextWidget(),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 1.0,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Obx(() {
                  if (_controller.addresses.isEmpty) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        SizedBox(
                          width: 130,
                          child: ListView.builder(
                            itemCount: _controller.addresses.length,
                            itemBuilder: (context, index) {
                              final address = _controller.addresses[index];
                              return ListTile(
                                tileColor: address.isSelected
                                    ? Colors.grey
                                    : Colors.transparent,
                                title: Text(
                                  address.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                onTap: () {
                                  _controller.selectedAddress.value = address;
                                  _controller.loadSubAddresses(address.code);
                                  _controller.address(address.name);
                                  _controller.update();
                                  // 선택 상태 초기화 및 현재 타일 선택 상태 설정
                                  for (var item in _controller.addresses) {
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
                            itemCount: _controller.subAddresses.length,
                            itemBuilder: (context, index) {
                              final subAddress =
                                  _controller.subAddresses[index];
                              return ListTile(
                                tileColor: subAddress.isSelected
                                    ? Colors.grey
                                    : Colors.transparent,
                                title: Text(
                                  subAddress.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                onTap: () {
                                  _controller.selectedAddress.value =
                                      subAddress;
                                  _controller
                                      .loadSubAddressDetails(subAddress.code);
                                  _controller.subAddressesR(
                                      subAddress.name);

                                  // 선택 상태 초기화 및 현재 타일 선택 상태 설정
                                  for (var item in _controller.subAddresses) {
                                    item.isSelected = false;
                                  }
                                  subAddress.isSelected = true;
                                  _controller.update();
                                },
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 100,
                          child: ListView.builder(
                            itemCount: _controller.subAddresses1.length,
                            itemBuilder: (context, index) {
                              final subAddresses1 =
                                  _controller.subAddresses1[index];
                              final bool lastIsSelected = subAddresses1 ==
                                  _controller.selectedAddress.value;
                              return ListTile(
                                tileColor: lastIsSelected
                                    ? Colors.grey
                                    : Colors.transparent,
                                title: Text(
                                  subAddresses1.name,
                                  style: const TextStyle(
                                    fontSize: 13,
                                  ),
                                ),
                                onTap: () {
                                  _controller.subAddresses1R(
                                      subAddresses1.name);
                                  _controller.selectedAddress.value =
                                      subAddresses1;
                                  _controller.update();
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
            _controller.addressStatus = true;
            _controller.update();
            Get.back();
          },
          child: const Text('확인'),
        ),
      ],
    );
  }
}
