import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../vm/ai_test_controller.dart';
import '../vm/login_ctrl.dart';

typedef OnAgeSelectedCallback = void Function(
    String selectedDropdown, int selected);

class AiDisableWidget extends StatefulWidget {
  final OnAgeSelectedCallback onDisabledSelected;

  const AiDisableWidget({
    required this.onDisabledSelected,
    Key? key,
  }) : super(key: key);

  @override
  State<AiDisableWidget> createState() => _AiDisableWidgetState();
}

class _AiDisableWidgetState extends State<AiDisableWidget> {
  // Property
    final AiTestController controller =
      Get.put(AiTestController()); // 액션 없으면 어사인 부분만 안해주면됨
      final LoginController loginController = Get.find<LoginController>();

  late List<String> disabled;
  late String selectedDropdown;
  late int selected;

  @override
  void initState() {
    super.initState();
    // isChecked = false;
    disabled = [
      '지적 장애',
      '지체 장애',
      '시각 장애',
      '청각 장애',
      '정신 장애',
    ];
    selectedDropdown = '지적 장애';
    selected = 1;

      int selectedValue = 0;

    // loginController.isLogged.value
    if (loginController.isLogged.value) {
      selectedValue = controller.userData!.gender == "남자" ? 1 : 2;
    } else {
      selectedValue = 0; // 원하는 값으로 설정해주세요
    }


  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 90,
                    height: 50,
                    child: DropdownButton(
                      value: selectedDropdown,
                      items: disabled.map((String item) {
                        return DropdownMenuItem<String>(
                          child: Text('$item'),
                          value: item,
                        );
                      }).toList(),
                      onChanged: (value) {
                        selectedDropdown = value!;
                        controller.disabledSelect = selectedDropdown;
                        // controller.selectedDisabled(selectedDropdown);
                        // aiTestController.onDropdownSelected(value!);
                        widget.onDisabledSelected(selectedDropdown, selected);
                        setState(() {});
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text('경증'),
                        Radio(
                          value: 1,
                          groupValue: selected,
                          onChanged: (value) {
                            selected = value!;
                            controller.radioDisabledSelect = selected;
                            widget.onDisabledSelected(
                                selectedDropdown, selected);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text('중증'),
                        Radio(
                          value: 2,
                          groupValue: selected,
                          onChanged: (value) {
                            selected = value!;
                            controller.radioDisabledSelect = selected;
                            widget.onDisabledSelected(
                                selectedDropdown, selected);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                width: 350,
                child: Divider(
                  color: Colors.grey,
                  thickness: 1.0,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Functions ---
} // End