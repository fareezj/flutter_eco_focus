import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/features/home/widgets/achievements_widget.dart';
import 'package:eco_focus/features/home/widgets/focus_time_graph_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final viewModel = Provider.of<HomeScreenViewModel>(context, listen: false);
    viewModel.getAllSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          IconButton(onPressed: () {}, icon: const Icon(Icons.start)),
      body: SafeArea(child: Consumer<HomeScreenViewModel>(
        builder: (context, value, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                const Text('Eco Focus'),
                const AchievementsWidget(),
                FocusTimeGraphWidget(),
                Text(value.xAxisList.toString()),
                Text(value.yAxisList.toString()),
                ElevatedButton(
                    onPressed: () =>
                        value.getAllSession().then((a) => print(a)),
                    child: const Text('Get Sessions')),
                Switch(
                  value: value.isDarkTheme,
                  onChanged: (_) {
                    value.switchTheme();
                  },
                ),
              ],
            ),
          );
        },
      )),
    );
  }
}
