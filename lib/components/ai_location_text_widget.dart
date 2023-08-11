import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/vm/ai_address_controller.dart';

class AiLocationTextWidget extends StatelessWidget {
  const AiLocationTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController _controller = Get.find<AddressController>();

    String address1 = "${_controller.address_result111}";
    String address2 = "${_controller.subAddress_result111}";
    String address3 = _controller.subAddresses1_result;

    return GetBuilder<AddressController>(
      builder: (controller) {
        return Center(
          child: Text(
            "$address1 $address2 $address3",
          ),
        );
      },
    );
  }
}
