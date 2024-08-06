import 'dart:math';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel =
          Provider.of<TreeGrowthViewModel>(context, listen: false);
      viewModel.plantTree(widget.sessionList, context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final double maxHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: 250.0,
      child: Center(
        child: Consumer<TreeGrowthViewModel>(
          builder: (context, value, child) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 250,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: value.plantedTrees.toList(),
                ),
              )
              // Stack(
              //   alignment: Alignment.bottomCenter,
              //   children: [
              //     Consumer<TreeGrowthViewModel>(
              //       builder: (context, value, child) {
              //         print(value.plantedTrees);
              //         return Row(
              //           children: value.plantedTrees.toList(),
              //         );
              //       },
              //     ),
              //     Container(
              //       height: 20.0,
              //       width: MediaQuery.of(context).size.width,
              //       decoration: const BoxDecoration(
              //         color: Colors.brown,
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(20.0),
              //           topRight: Radius.circular(20.0),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(height: 20),
              // ElevatedButton(onPressed: _toggleImage, child: const Text('change'))
            ],
          ),
        ),
      ),
    );
  }
}
