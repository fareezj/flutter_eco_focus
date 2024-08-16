import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/features/home/widgets/focus_time_graph_widget.dart';
import 'package:eco_focus/features/home/widgets/category_distribution_pie_chart.dart';
import 'package:eco_focus/features/treeGrowth/tree_growth_home_widget.dart';
import 'package:eco_focus/router/router_generator.dart';
import 'package:eco_focus/shared/constants/constants.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var initialStartDate = DateTime.now().copyWith(hour: 0, minute: 0, second: 0);
  var intialEndDate = DateTime.now()
      .add(const Duration(days: 5))
      .copyWith(hour: 0, minute: 0, second: 0);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getPlantedTrees();
    });
  }

  getPlantedTrees() async {
    final homeVM = Provider.of<HomeScreenViewModel>(context, listen: false);
    DateTime now = DateTime.now();

    await homeVM.getAllSession(
      context: context,
      startDate: now
          .subtract(Duration(days: now.weekday - 1))
          .copyWith(hour: 0, minute: 0, second: 0),
      endDate: DateTime.now()
          .add(const Duration(days: 5))
          .copyWith(hour: 0, minute: 0, second: 0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          IconButton(onPressed: () {}, icon: const Icon(Icons.start)),
      body: SafeArea(child: Consumer<HomeScreenViewModel>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () => value.switchDate(
                              DateSwitchMode.previous, context),
                          child: const Icon(Icons.arrow_back_ios_new)),
                      TextWidgets.secondaryTitleText(
                          text: Constants.dateFormat
                              .format(value.startDate)
                              .toString(),
                          fontSize: 14),
                      const SizedBox(width: 20.0),
                      TextWidgets.secondaryTitleText(
                          text: Constants.dateFormat
                              .format(value.endDate)
                              .toString(),
                          fontSize: 14),
                      GestureDetector(
                          onTap: () =>
                              value.switchDate(DateSwitchMode.next, context),
                          child: const Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                  if (value.sessions != null) ...[
                    if (value.sessions!.isNotEmpty) ...[
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(
                          context,
                          '/session-list',
                          arguments: SessionListArguments(
                              sessionList: value.sessions!),
                        ),
                        child: TreeGrowthHomeWidget(
                          plantedTrees: value.plantedTrees,
                        ),
                      ),
                    ] else ...[
                      SizedBox(
                        height: 250.0,
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: TextWidgets.regularText(
                                text: 'No focus recorded',
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 20.0,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                  color: Colors.brown,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/session-list',
                      arguments:
                          SessionListArguments(sessionList: value.sessions!),
                    ),
                    child: const FocusTimeGraphWidget(),
                  ),
                  const SizedBox(height: 30.0),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(
                      context,
                      '/session-list',
                      arguments:
                          SessionListArguments(sessionList: value.sessions!),
                    ),
                    child: const CategoryDistributionPieChart(),
                  )
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
