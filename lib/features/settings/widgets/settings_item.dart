import 'package:eco_focus/features/settings/settings_view_model.dart';
import 'package:eco_focus/shared/widgets/text_widgets.dart';
import 'package:eco_focus/style/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsItem extends StatelessWidget {
  final String title;
  final bool isSwitchingSetting;
  const SettingsItem(
      {super.key, required this.title, this.isSwitchingSetting = false});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondaryContainer,
            borderRadius: const BorderRadius.all(
              Radius.circular(12.0),
            ),
            border: const Border(
              bottom: BorderSide(
                color: AppColors.accentColor,
              ),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isSwitchingSetting) ...[
              SwitchingSettings(title: title)
            ] else ...[
              TextWidgets.secondaryTitleText(
                text: title,
                fontSize: 20.0,
              ),
            ]
          ],
        ));
  }
}

class SwitchingSettings extends StatelessWidget {
  final String title;
  const SwitchingSettings({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: TextWidgets.secondaryTitleText(
            text: title,
            fontSize: 20.0,
          ),
        ),
        Consumer<SettingsViewModel>(builder: (context, value, child) {
          return Switch(
            value: value.isDarkTheme,
            onChanged: (_) {
              value.switchTheme();
            },
          );
        }),
      ],
    );
  }
}
