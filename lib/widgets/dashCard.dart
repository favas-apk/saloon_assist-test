// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_assist/constants/colors.dart';
import 'package:saloon_assist/constants/constants.dart';
import 'package:saloon_assist/responsive.dart';

class DashCard extends StatelessWidget {
  DashCard({
    super.key,
    required this.asset,
    required this.title,
    required this.value,
  });
  String asset;
  String title;
  String value;
  @override
  Widget build(BuildContext context) {
    // bool isTab = Responsive.isTablet(context);
    bool isMobile = Responsive.isMobile(context);
    return Card(
      color: staffDashbordColor,
      child: Container(
        height: isMobile
            ? MediaQuery.of(context).size.height * 0.23
            : MediaQuery.of(context).size.height * 0.20,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image(
              color: Colors.black87,
              // height: MediaQuery.of(context).size.height * .1,
              height: isMobile
                  ? MediaQuery.of(context).size.height * .06
                  : MediaQuery.of(context).size.height * .07,
              image: AssetImage(asset),
            ),
            const Spacer(),
            const Divider(
              color: Colors.transparent,
              height: 2,
            ),
            Text(
              title,
              style: GoogleFonts.poppins(
                color: Colors.black87,
                fontSize: isMobile ? 18 : 22,
                fontWeight: FontWeight.w500,
              ),
            ),
            divider,
            Text(
              value,
              style: GoogleFonts.poppins(
                  fontSize: isMobile ? 18 : 22, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
