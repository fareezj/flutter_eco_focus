import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class SessionListItemTitle extends StatelessWidget {
  const SessionListItemTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidgets.secondaryTitleText(text: 'Category', fontSize: 12.0),
              TextWidgets.secondaryTitleText(
                  text: 'Percentage', fontSize: 12.0),
              TextWidgets.secondaryTitleText(
                  text: 'Total Hours', fontSize: 12.0),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}

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
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidgets.secondaryTitleText(
                text: title,
                fontSize: 14.0,
              ),
              TextWidgets.secondaryTitleText(
                text: percentage,
                fontSize: 14.0,
              ),
              TextWidgets.secondaryTitleText(
                text: totalHours.toString(),
                fontSize: 14.0,
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}
