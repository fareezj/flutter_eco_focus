import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final SessionRepository sessionRepository;

  HomeScreenViewModel({required this.sessionRepository});

  bool isDarkTheme = false;

  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  Future<List<SessionModel>?> getAllSession() async {
    try {
      return await sessionRepository.getAllSession();
    } catch (e) {
      throw Exception(e);
    }
  }
}
