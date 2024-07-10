import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:flutter/material.dart';

class HomeScreenViewModel extends ChangeNotifier {
  final SessionRepository sessionRepository;

  HomeScreenViewModel({required this.sessionRepository});

  bool isDarkTheme = false;
  List<SessionModel>? sessions;
  List<String> xAxisList = [];
  List<String> yAxisList = [];

  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  Future<List<SessionModel>?> getAllSession() async {
    try {
      xAxisList.clear();
      yAxisList.clear();
      var result = await sessionRepository.getAllSession();
      sessions = result;
      notifyListeners();

      if (result != null) {
        for (var element in result) {
          xAxisList.add(element.createdDate);
          yAxisList.add(element.focusedTime);
        }
      }
      notifyListeners();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
