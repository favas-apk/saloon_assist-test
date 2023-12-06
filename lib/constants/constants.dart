// ignore_for_file: use_full_hex_values_for_flutter_colors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:saloon_assist/constants/colors.dart';

TextStyle splashTextStyle =
    TextStyle(color: primaryColor, fontSize: 20, fontWeight: FontWeight.bold);
Widget space(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .02,
  );
}

Widget tabSpace(BuildContext context) {
  return SizedBox(
    height: MediaQuery.of(context).size.height * .05,
  );
}

TextStyle headStyle = GoogleFonts.signikaNegative(
  fontSize: 22,
  fontWeight: FontWeight.bold,
);
TextStyle titleStyle = GoogleFonts.signikaNegative(
  fontWeight: FontWeight.bold,
);
TextStyle reportValueStyle =
    const TextStyle(fontWeight: FontWeight.w700, fontSize: 12);
TextStyle whiteText = const TextStyle(color: Colors.white);
TextStyle blackText = const TextStyle(color: Colors.black);
TextStyle poppinsStyleHead1 = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 20,
);
TextStyle poppinsStyleH2 = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
  fontSize: 14,
);
TextStyle poppinsStyleH3 = GoogleFonts.poppins(
  fontWeight: FontWeight.w600,
  fontSize: 18,
);
TextStyle poppinsHeadStyle2 = GoogleFonts.poppins(
  fontWeight: FontWeight.bold,
);
Widget divider = Divider(
  color: Colors.grey.shade300,
);
