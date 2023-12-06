// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class ReportItems extends StatelessWidget {
  ReportItems({
    super.key,
    required this.title,
    required this.value,
  });
  String title;
  String value;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(title),
        ),
        const Text(':'),
        Expanded(
          child: Center(child: Text(value)),
        ),
      ],
    );
  }
}
