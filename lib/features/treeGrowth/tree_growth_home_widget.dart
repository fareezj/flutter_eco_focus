import 'dart:math';

import 'package:eco_focus/features/home/home_screen_view_model.dart';
import 'package:eco_focus/features/treeGrowth/tree_growth_view_model.dart';
import 'package:eco_focus/models/session/session_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TreeGrowthHomeWidget extends StatefulWidget {
  final List<SessionModel> sessionList;
  const TreeGrowthHomeWidget({super.key, required this.sessionList});

  @override
  State<TreeGrowthHomeWidget> createState() => _TreeGrowthHomeWidgetState();
}

class _TreeGrowthHomeWidgetState extends State<TreeGrowthHomeWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TreeGrowthViewModel>(context, listen: false);
    if (widget.sessionList.isNotEmpty) {
      viewModel.plantTree(widget.sessionList, context);
    }

    return SizedBox(
      height: 250.0,
      child: Center(
        child: Consumer<TreeGrowthViewModel>(builder: (context, value, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: value.plantedTrees.toList(),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
