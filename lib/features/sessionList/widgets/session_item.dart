import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class SessionItem extends StatelessWidget {
  final String title;
  final String value;
  const SessionItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidgets.secondaryTitleText(text: title, fontSize: 14.0),
          TextWidgets.regularText(text: value, fontSize: 14.0)
        ],
      ),
    );
  }
}
