import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  bool isDarkTheme = false;

  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }
}
