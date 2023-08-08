import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AgreementViewWidget extends StatelessWidget {
  const AgreementViewWidget({
    super.key,
    required this.agreement,
  });
  final String agreement;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiary)),
      height: 100.h,
      child: SingleChildScrollView(
        child: Column(
          children: [MarkdownBody(data: agreement)],
        ),
      ),
    );
  }
}
