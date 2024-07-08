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

  static Text secondaryTitleText({
    required String text,
  }) {
    return Text(
      text,
      style: GoogleFonts.workSans(
        fontSize: 20.0,
        fontWeight: FontWeight.normal,
      ),
    );
  }
}
