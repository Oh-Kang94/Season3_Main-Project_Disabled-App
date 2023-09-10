import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../vm/ai_test/ai_test_controller.dart';

typedef OnEmploySelectedCallback = void Function(bool selectStatus);

class AiEmployDayWidget extends StatefulWidget {
  final OnEmploySelectedCallback onEmploySelected;

  const AiEmployDayWidget({
    Key? key,
    required this.onEmploySelected,
  }) : super(key: key);

  @override
  State<AiEmployDayWidget> createState() => _AiEmployDayWidgetState();
}

class _AiEmployDayWidgetState extends State<AiEmployDayWidget> {
  // Property
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AiTestController>(
      builder: (controller) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  DateTime initialTime =
                      DateTime.now().add(const Duration(minutes: 1));

                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      backgroundColor:
                          Colors.white.withOpacity(1.0), // 배경색 및 불투명도 조절
                      child: SizedBox(
                        height: 250,
                        child: Column(
                          children: [
                            Expanded(
                              child: CupertinoDatePicker(
                                mode: CupertinoDatePickerMode.date,
                                minimumYear: DateTime.now().year,
                                minimumDate: DateTime.now(),
                                initialDateTime: initialTime,
                                onDateTimeChanged: (DateTime newTime) {
                                  dateTime = newTime;
                                },
                                use24hFormat: true,
                              ),
                            ),
                            CupertinoButton(
                              onPressed: () {
                                DateTime now = DateTime.now();
                                bool selectStatus = !now.isAfter(dateTime);
                                if (!selectStatus) {
                                  // 현재 날짜가 선택한 날짜보다 더 과거인 경우
                                  Fluttertoast.showToast(
                                    msg: "지난 일자는 취업일자로 선택이 불가능합니다!",
                                    gravity: ToastGravity.TOP, // 띄우는 위치
                                    fontSize: 20,
                                    toastLength: Toast.LENGTH_LONG, // 띄우는 시간
                                  );
                                } else {
                                  Get.back();
                                  controller.employMonth =
                                      dateTime.month.toString();
                                  widget.onEmploySelected(selectStatus);
                                }
                              },
                              child: const Text('선택완료'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: const Text(
                  '날짜 선택',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
              Text(
                '${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일',
                style: const TextStyle(
                  fontSize: 18,
                ),
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
}
