import 'package:flutter/material.dart';

class FocusTimeGraphWidget extends StatefulWidget {
  const FocusTimeGraphWidget({super.key});

  @override
  State<FocusTimeGraphWidget> createState() => _FocusTimeGraphWidgetState();
}

class _FocusTimeGraphWidgetState extends State<FocusTimeGraphWidget> {
  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          Text('Focus Time'),
        ],
      ),
    );
  }
}
