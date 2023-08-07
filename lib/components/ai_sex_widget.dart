import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';

import '../model/aiTestModel.dart';

class AiSexWidget extends StatefulWidget {
  @override
  State<AiSexWidget> createState() => _AiSexWidgetState();
}

class _AiSexWidgetState extends State<AiSexWidget> {
  final AiTestController aiTestController = Get.put(AiTestController());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('남성'),
                    Radio(
                      value: 1,
                      groupValue: aiTestController.sexSelected.value,
                      onChanged: (value) {
                        aiTestController.onSexSelected(value as int);
                        setState(() {
                          
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text('여성'),
                    Radio(
                      value: 2,
                      groupValue: aiTestController.sexSelected.value,
                      onChanged: (value) {
                        aiTestController.onSexSelected(value as int);
                        setState(() {
                          
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
            const Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
          ],
        ),
      ),
    );
  }
}
