import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../vm/ai_test/ai_address_controller.dart';
class AiLocationTextWidget extends StatelessWidget {
  const AiLocationTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final AddressController controller = Get.find<AddressController>();

    String address1 = controller.addressResult111;
    String address2 = controller.subAddressResult111;
    String address3 = controller.subAddresses1Result;

    return GetBuilder<AddressController>(
      builder: (controller) {
        return Center(
          child: Text(
            "$address1 $address2 $address3",
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
