import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:season3_team1_mainproject/vm/ai_address_controller.dart';

class AiLocationResultTextWidget extends StatelessWidget {
  const AiLocationResultTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.find<AddressController>();

    // String address1 = controller.address_result111;
    // String address2 = controller.subAddress_result111;
    // String address3 = controller.subAddresses1_result;

    return GetBuilder<AddressController>(
      builder: (controller) {
        return Center(
          child: Text(
            "${controller.address_result} ${controller.subAddress_result} ${controller.subAddresses1_result}",
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
        );
      },
    );
  }
}
