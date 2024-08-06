import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:flutter/material.dart';

enum DateSwitchMode { previous, next }

class HomeScreenViewModel extends ChangeNotifier {
  final SessionRepository sessionRepository;

  HomeScreenViewModel({required this.sessionRepository}) {
    DateTime now = DateTime.now();
    startDate = now
        .subtract(Duration(days: now.weekday - 1))
        .copyWith(hour: 0, minute: 0, second: 0);
    endDate = startDate
        .add(const Duration(days: 6))
        .copyWith(hour: 0, minute: 0, second: 0);
  }

  bool isDarkTheme = false;
  List<SessionModel>? sessions;
  List<String> xAxisList = [];
  List<String> yAxisList = [];
  late DateTime startDate;
  late DateTime endDate;

  void switchDate(DateSwitchMode mode) {
    if (mode == DateSwitchMode.next) {
      startDate = startDate.add(const Duration(days: 7));
      endDate = endDate.add(const Duration(days: 7));
    } else {
      startDate = startDate.subtract(const Duration(days: 7));
      endDate = endDate.subtract(const Duration(days: 7));
    }
    getAllSession(startDate: startDate, endDate: endDate);
    notifyListeners();
  }

  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  Future<List<SessionModel>?> getAllSession(
      {required DateTime startDate, required DateTime endDate}) async {
    try {
      List<SessionModel> result = [];
      sessions?.clear();
      xAxisList.clear();
      yAxisList.clear();
      var list = await sessionRepository.getAllSession();
      print(list);
      notifyListeners();

      if (list != null) {
        for (var element in list) {
          DateTime sessionDate = DateTime.parse(element.createdDate);

          print('Start Date: $startDate');
          print('End Date: $endDate');

          print(
              sessionDate.isAfter(startDate) && sessionDate.isBefore(endDate) ||
                  sessionDate.isAtSameMomentAs(startDate) ||
                  sessionDate.isAtSameMomentAs(endDate));

          if (sessionDate.isAfter(startDate) && sessionDate.isBefore(endDate) ||
              sessionDate.isAtSameMomentAs(startDate) ||
              sessionDate.isAtSameMomentAs(endDate)) {
            xAxisList.add(element.createdDate);
            yAxisList.add(element.focusedTime);
            result.add(element);
          }
        }
      }
      sessions = result;
      notifyListeners();
      return result;
    } catch (e) {
      throw Exception(e);
    }
  }
}
