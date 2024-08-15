import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class SessionListItem extends StatelessWidget {
  final String title;
  final String percentage;
  final String totalHours;

  const SessionListItem({
    super.key,
    required this.title,
    required this.percentage,
    required this.totalHours,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextWidgets.regularText(text: title),
            TextWidgets.regularText(text: percentage),
            TextWidgets.regularText(text: totalHours),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
