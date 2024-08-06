import 'dart:math';

import 'package:eco_focus/models/session/session_model.dart';
import 'package:flutter/material.dart';

class TreeGrowthViewModel extends ChangeNotifier {
  List<Widget> plantedTrees = [];

  plantTree(List<SessionModel> sessionList, BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final Random random = Random();
    List<Widget> filteredTrees = [];

    final double randomLeft =
        random.nextDouble() * (maxWidth - 150); // 150 is the image width

    for (var element in sessionList) {
      filteredTrees.add(Positioned(
        left: random.nextDouble() * (maxWidth - 150),
        child: Image.asset(
          'assets/images/tree-${(int.parse(element.treeGrowthLevel) + 1).toString()}.png',
          height: 150.0,
          width: 150.0,
          fit: BoxFit.contain,
        ),
      ));
    }
    filteredTrees.add(
      Container(
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
    );
    plantedTrees = filteredTrees;
    notifyListeners();
  }
}
