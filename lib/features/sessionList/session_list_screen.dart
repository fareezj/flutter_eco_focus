import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/shared/constants/constants.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionListScreen extends StatefulWidget {
  const SessionListScreen({super.key});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Consumer<HomeScreenViewModel>(
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidgets.titleText(text: 'Session Overview'),
                  const SizedBox(height: 15.0),
                  TextWidgets.secondaryTitleText(
                      text:
                          '${Constants.dateFormat.format(value.startDate)} to ${Constants.dateFormat.format(value.endDate)}'),
                  Card(
                    child: Column(
                      children: [
                        TextWidgets.regularText(text: 'Total Hours: '),
                        TextWidgets.regularText(
                            text: value.totalHours.toString())
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
