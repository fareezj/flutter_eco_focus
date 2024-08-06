import 'package:eco_focus/features/settings/widgets/settings_item.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidgets.titleText(text: 'Settings'),
              const SizedBox(height: 30.0),
              const SettingsItem(
                title: 'Dark Theme',
                isSwitchingSetting: true,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
