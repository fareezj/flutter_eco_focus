import 'package:flutter/material.dart';

class TreeGrowthHomeWidget extends StatefulWidget {
  final List<Widget> plantedTrees;
  const TreeGrowthHomeWidget({super.key, required this.plantedTrees});

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
    return SizedBox(
      height: 250.0,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: widget.plantedTrees.toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
