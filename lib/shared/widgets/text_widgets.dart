import 'package:flutter/material.dart';

class TextWidgets {
  static Text titleText({
    required String text,
  }) {
    return Text(
      text,
      style: const TextStyle(
        fontFamily: 'Barlow',
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
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
      style: TextStyle(
        fontFamily: 'Barlow',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  static Text regularText(
      {required String text,
      double fontSize = 20.0,
      TextAlign textAlign = TextAlign.start}) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontFamily: 'Barlow',
        fontSize: fontSize,
      ),
    );
  }
}
