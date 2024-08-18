import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/features/sessionList/session_list_view_model.dart';
import 'package:eco_focus/features/sessionList/widgets/session_item.dart';
import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/shared/constants/constants.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:eco_focus/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionListScreen extends StatefulWidget {
  final List<SessionModel> sessionList;
  const SessionListScreen({super.key, required this.sessionList});

  @override
  State<SessionListScreen> createState() => _SessionListScreenState();
}

class _SessionListScreenState extends State<SessionListScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = Provider.of<SessionListViewModel>(context, listen: false);
      vm.analyseSessions(widget.sessionList);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextWidgets.titleText(text: 'Session Overview'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: Consumer<HomeScreenViewModel>(
              builder: (context, homeValue, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15.0),
                  Consumer<SessionListViewModel>(
                    builder: (context, value, child) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: Column(
                            children: [
                              TextWidgets.secondaryTitleText(text: 'Summary'),
                              const SizedBox(height: 25.0),
                              SessionItem(
                                  title: 'Duration',
                                  value:
                                      "${Constants.dateFormat.format(homeValue.startDate)} to ${Constants.dateFormat.format(homeValue.endDate)}"),
                              SessionItem(
                                title: 'Total Hours',
                                value: Utils().convertTimeToHoursMins(
                                    homeValue.totalHours),
                              ),
                              SessionItem(
                                title: 'Highest Session',
                                value: value.highestSession,
                              ),
                              SessionItem(
                                title: 'Lowest Session',
                                value: value.lowestSession,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30.0),
                  Column(
                    children: homeValue.sessions!.map((e) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidgets.secondaryTitleText(
                                        text: e.name, fontSize: 16.0),
                                    TextWidgets.secondaryTitleText(
                                        text: '${e.focusedTime} mins',
                                        fontSize: 16.0),
                                  ],
                                ),
                                const SizedBox(height: 8.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextWidgets.regularText(
                                      text: 'Achivements: ${e.treeGrowthLevel}',
                                      fontSize: 14.0,
                                    ),
                                    TextWidgets.regularText(
                                      text: Constants.dateFormat
                                          .format(DateTime.parse(e.createdDate))
                                          .toString(),
                                      fontSize: 14.0,
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
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
