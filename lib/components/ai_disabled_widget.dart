import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

import '../model/aiTestModel.dart';

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
  // late bool isChecked;
  late List<String> disabled;
  late String selectedDropdown;
  late int selected;

  @override
  void initState() {
    super.initState();
    // isChecked = false;
    disabled = [
      '지적장애',
      '지체장애',
      '시각장애',
      '청각장애',
      '정신장애',
    ];
    selectedDropdown = '지적장애';
    selected = 1;
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
                        setState(() {});
                        selectedDropdown = value!;
                        controller.disabledSelect = selectedDropdown;
                        // controller.selectedDisabled(selectedDropdown);
                        // aiTestController.onDropdownSelected(value!);
                        widget.onDisabledSelected(selectedDropdown, selected);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text('경증장애'),
                        Radio(
                          value: 1,
                          groupValue: selected,
                          onChanged: (value) {
                            selected = value!;
                            setState(() {});
                            controller.radioDisabledSelect = selected;
                            widget.onDisabledSelected(
                                selectedDropdown, selected);
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Text('중증장애'),
                        Radio(
                          value: 2,
                          groupValue: selected,
                          onChanged: (value) {
                            selected = value!;
                            setState(() {});
                            controller.radioDisabledSelect = selected;
                            widget.onDisabledSelected(
                                selectedDropdown, selected);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.grey,
                thickness: 2.0,
              ),
            ],
          ),
        );
      },
    );
  }

  // --- Functions ---
} // End