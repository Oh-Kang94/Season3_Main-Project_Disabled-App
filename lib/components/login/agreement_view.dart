import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AgreementViewWidget extends StatelessWidget {
  const AgreementViewWidget({
    super.key,
    required this.agreement,
    required this.height,
  });
  final String agreement;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).colorScheme.tertiary)),
      height: height,
      child: SingleChildScrollView(
        child: Column(
          children: [MarkdownBody(data: agreement)],
        ),
      ),
    );
  }
}
