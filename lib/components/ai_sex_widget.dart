import 'package:flutter/material.dart';

class AiSexWidget extends StatefulWidget {
  AiSexWidget({super.key});

  @override
  State<AiSexWidget> createState() => _AiSexWidgetState();
}

class _AiSexWidgetState extends State<AiSexWidget> {
  int sexSelected = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('남성'),
                Radio(
                  value: 1,
                  groupValue: sexSelected,
                  onChanged: (value) {
                    sexSelected = value!;
                    setState(() {});
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
                  groupValue: sexSelected,
                  onChanged: (value) {
                    sexSelected = value!;
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
