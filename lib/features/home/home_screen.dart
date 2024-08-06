import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/features/home/widgets/achievements_widget.dart';
import 'package:eco_focus/features/home/widgets/focus_time_graph_widget.dart';
import 'package:eco_focus/features/treeGrowth/tree_growth_home_widget.dart';
import 'package:eco_focus/features/treeGrowth/tree_growth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  DateFormat dateFormatMonth = DateFormat('MMMM');
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
    print('Get planted trees');
    // final treeGrowthVM =
    //     Provider.of<TreeGrowthViewModel>(context, listen: false);
    final homeVM = Provider.of<HomeScreenViewModel>(context, listen: false);
    DateTime now = DateTime.now();

    var result = await homeVM.getAllSession(
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
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);

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
                  const Text('Eco Focus'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                          onTap: () =>
                              value.switchDate(DateSwitchMode.previous),
                          child: const Icon(Icons.arrow_back_ios_new)),
                      Text(dateFormat.format(value.startDate).toString()),
                      const SizedBox(width: 20.0),
                      Text(dateFormat.format(value.endDate).toString()),
                      GestureDetector(
                          onTap: () => value.switchDate(DateSwitchMode.next),
                          child: const Icon(Icons.arrow_forward_ios)),
                    ],
                  ),
                  if (viewModel.sessions != null) ...[
                    if (viewModel.sessions!.isNotEmpty) ...[
                      TreeGrowthHomeWidget(
                        sessionList: viewModel.sessions!,
                      ),
                    ] else ...[
                      const SizedBox(
                        height: 250.0,
                      )
                    ],
                  ],
                  const FocusTimeGraphWidget(),
                  Visibility(
                    visible: false,
                    child: ElevatedButton(
                      onPressed: () => value.getAllSession(
                        startDate: DateTime.now(),
                        endDate: DateTime.now().add(
                          const Duration(days: 6),
                        ),
                      ),
                      child: const Text('Get Sessions'),
                    ),
                  ),
                  Switch(
                    value: value.isDarkTheme,
                    onChanged: (_) {
                      value.switchTheme();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
