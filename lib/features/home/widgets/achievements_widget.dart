import 'package:flutter/material.dart';

class AchievementsWidget extends StatefulWidget {
  const AchievementsWidget({super.key});

  @override
  State<AchievementsWidget> createState() => _AchievementsWidgetState();
}

class _AchievementsWidgetState extends State<AchievementsWidget> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 300,
      child: Text('Achievements'),
    );
  }
}
