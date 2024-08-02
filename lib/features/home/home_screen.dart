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
    viewModel.getAllSession(
      startDate: DateTime.parse("2024-07-25"),
      endDate: DateTime.parse("2024-07-25").add(const Duration(days: 5)),
    );

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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Column(
                children: [
                  const Text('Eco Focus'),
                  const AchievementsWidget(),
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
