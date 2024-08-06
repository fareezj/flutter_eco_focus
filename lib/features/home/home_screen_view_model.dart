import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
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
      xAxisList.clear();
      yAxisList.clear();
      var list = await sessionRepository.getAllSession();
      notifyListeners();

      if (list != null) {
        for (var element in list) {
          DateTime sessionDate = DateTime.parse(element.createdDate);

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

  List<PieChartSectionData> plotPieChart(List<SessionModel> sessionList) {
    final Map<String, double> categoryTimeMap = {};

    for (var session in sessionList) {
      if (categoryTimeMap.containsKey(session.categoryId)) {
        categoryTimeMap[session.categoryId] =
            categoryTimeMap[session.categoryId]! +
                double.parse(session.focusedTime.substring(0, 2));
      } else {
        categoryTimeMap[session.categoryId] =
            double.parse(session.focusedTime.substring(0, 2));
      }
    }
    final double totalTime = categoryTimeMap.values.reduce((a, b) => a + b);

    return categoryTimeMap.entries.map((entry) {
      final double percentage = (entry.value / totalTime) * 100;
      return PieChartSectionData(
        color: getColorForCategory(entry.key),
        value: percentage,
        title: '${entry.key}: ${percentage.toStringAsFixed(1)}%',
        radius: 70,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontFamily: "Barlow",
          fontWeight: FontWeight.w600,
          color: Color(0xffffffff),
        ),
      );
    }).toList();
  }

  Color getColorForCategory(String category) {
    // Assign a color based on the category
    switch (category) {
      case 'Work':
        return Colors.blue;
      case 'Study':
        return Colors.green;
      case 'Read':
        return Colors.red;
      // Add more cases for different categories
      default:
        return Colors.grey;
    }
  }
}
