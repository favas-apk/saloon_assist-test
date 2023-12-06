// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/responsive.dart';

class StaffDetailsItem extends StatelessWidget {
  StaffDetailsItem({
    super.key,
    required this.title,
    required this.value,
  });
  String value;
  String title;
  @override
  Widget build(BuildContext context) {
    bool isMobile = Responsive.isMobile(context);
    bool isTab = Responsive.isTablet(context);
    return Card(
      elevation: .8,
      // color: Colors.amber,
      child: Padding(
        padding: isMobile
            ? const EdgeInsets.all(15)
            : isTab
                ? const EdgeInsets.all(20)
                : const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title,
              style: titleStyle,
            ),
            const Divider(),
            Center(
              child: Text(
                value,
                style: const TextStyle(
                    color: Colors.blueGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
                textAlign: TextAlign.center,
                // style: reportValueStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
