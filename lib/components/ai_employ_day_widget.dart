import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            onPressed: _showDatePicker,
            child: const Text('날짜 선택'),
          ),
          Text('${dateTime.year}년 ${dateTime.month}월 ${dateTime.day}일'),
          const Divider(
            color: Colors.grey,
            thickness: 2.0,
          ),
        ],
      ),
    );
  }

  void _showDatePicker() {
    // 선택시간을 미래로 선택하게끔 현재시간 +1분 해주기
    DateTime initialTime = DateTime.now().add(Duration(minutes: 1));

    showCupertinoModalPopup(
      context: context,
      builder: (context) => SizedBox(
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
                  setState(() {});
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
                  widget.onEmploySelected(selectStatus);
                }
              },
              child: const Text('선택완료'),
            ),
          ],
        ),
      ),
    );
  }
}
