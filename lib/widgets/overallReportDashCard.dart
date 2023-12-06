// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saloon_assist/constants/constants.dart';

class OverallReportDashCard extends StatelessWidget {
  const OverallReportDashCard({
    super.key,
    required this.isMobile,
    required this.icon,
    required this.title,
    required this.value,
  });

  final bool isMobile;
  // final String image;
  final String title;
  final String value;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            FaIcon(icon),
            /* Image(
              color: Colors.black38,
              height: isMobile
                  ? MediaQuery.of(context).size.height * .067
                  : MediaQuery.of(context).size.height * .067,
              image: AssetImage(image),
            ), */
            const Spacer(),
            Text(
              title,
              style: titleStyle,
            ),
            const Divider(),
            Text(
              value,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: isMobile ? 18 : 20),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
