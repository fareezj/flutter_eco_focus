import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextWidgets {
  static Text titleText({
    required String text,
  }) {
    return Text(
      text,
      style: GoogleFonts.workSans(
        fontSize: 24.0,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  static Text secondaryTitleText(
      {required String text,
      double fontSize = 20.0,
      TextAlign textAlign = TextAlign.start}) {
    return Text(
      text,
      textAlign: textAlign,
      style: GoogleFonts.workSans(
        fontSize: fontSize,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
