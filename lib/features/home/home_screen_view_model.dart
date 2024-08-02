import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:flutter/material.dart';

enum DateSwitchMode { previous, next }

class HomeScreenViewModel extends ChangeNotifier {
  final SessionRepository sessionRepository;

  HomeScreenViewModel({required this.sessionRepository});

  bool isDarkTheme = false;
  List<SessionModel>? sessions;
  List<String> xAxisList = [];
  List<String> yAxisList = [];

  DateTime startDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day)
          .subtract(const Duration(days: 5));

  DateTime endDate = DateTime(DateTime.now().year, DateTime.now().month + 1, 0)
      .subtract(const Duration(days: 5))
      .add(const Duration(days: 5));

  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  void switchDate(DateSwitchMode mode) {
    if (mode == DateSwitchMode.next) {
      startDate = startDate.add(const Duration(days: 5));
      endDate = endDate.add(const Duration(days: 5));
    } else {
      startDate = startDate.subtract(const Duration(days: 5));
      endDate = endDate.subtract(const Duration(days: 5));
    }
    getAllSession(startDate: startDate, endDate: endDate);
    notifyListeners();
  }

  Future<List<SessionModel>?> getAllSession(
      {required DateTime startDate, required DateTime endDate}) async {
    try {
      xAxisList.clear();
      yAxisList.clear();
      var result = await sessionRepository.getAllSession();
      sessions = result;
      notifyListeners();

      if (result != null) {
        for (var element in result) {
          DateTime sessionDate = DateTime.parse(element.createdDate);
          if (sessionDate.isAfter(startDate) && sessionDate.isBefore(endDate) ||
              sessionDate.isAtSameMomentAs(startDate) ||
              sessionDate.isAtSameMomentAs(endDate)) {
            xAxisList.add(element.createdDate);
            yAxisList.add(element.focusedTime);
          }
        }
      }
      notifyListeners();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
