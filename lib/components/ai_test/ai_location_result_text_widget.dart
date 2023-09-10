import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../vm/ai_test/ai_address_controller.dart';

class AiLocationResultTextWidget extends StatelessWidget {
  const AiLocationResultTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddressController>(
      builder: (controller) {
        return Center(
          child: Text(
            "${controller.addressResult} ${controller.subAddressResult} ${controller.subAddresses1Result}",
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
