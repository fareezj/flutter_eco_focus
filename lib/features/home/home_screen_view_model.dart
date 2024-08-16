import 'dart:math';
import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:fl_chart/fl_chart.dart';
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
  List<Widget> plantedTrees = [];
  List<SessionDistributionModel> sessionDetailsList = [];
  late DateTime startDate;
  late DateTime endDate;
  double totalHours = 0.0;

  void switchDate(DateSwitchMode mode, BuildContext context) {
    if (mode == DateSwitchMode.next) {
      startDate = startDate.add(const Duration(days: 7));
      endDate = endDate.add(const Duration(days: 7));
    } else {
      startDate = startDate.subtract(const Duration(days: 7));
      endDate = endDate.subtract(const Duration(days: 7));
    }
    getAllSession(startDate: startDate, endDate: endDate, context: context);
    notifyListeners();
  }

  void switchTheme() {
    isDarkTheme = !isDarkTheme;
    notifyListeners();
  }

  Future<List<SessionModel>?> getAllSession({
    required DateTime startDate,
    required DateTime endDate,
    required BuildContext context,
  }) async {
    try {
      List<SessionModel> result = [];
      Set<String> xAxisSet = {};
      yAxisList.clear();
      var list = await sessionRepository.getAllSession();
      notifyListeners();

      if (list != null) {
        for (var element in list) {
          DateTime sessionDate = DateTime.parse(element.createdDate);

          if (sessionDate.isAfter(startDate) && sessionDate.isBefore(endDate) ||
              sessionDate.isAtSameMomentAs(startDate) ||
              sessionDate.isAtSameMomentAs(endDate)) {
            xAxisSet.add(element.createdDate);
            yAxisList.add(element.focusedTime);
            result.add(element);
          }
        }
      }

      xAxisList = xAxisSet.toList();
      plantTree(result, context);
      sessions = result;
      notifyListeners();

      return result;
    } catch (e) {
      throw Exception(e);
    }
  }

  plantTree(List<SessionModel> sessionList, BuildContext context) {
    final double maxWidth = MediaQuery.of(context).size.width;
    final Random random = Random();
    List<Widget> filteredTrees = [];

    for (var element in sessionList) {
      final double randomLeft = random.nextDouble() * (maxWidth - 150);

      filteredTrees.add(Positioned(
        left: randomLeft,
        child: Image.asset(
          'assets/images/tree-${(int.parse(element.treeGrowthLevel) + 1).toString()}.png',
          height: 150.0,
          width: 150.0,
          fit: BoxFit.contain,
        ),
      ));
    }
    filteredTrees.add(
      Container(
        height: 20.0,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.brown,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
      ),
    );
    plantedTrees = filteredTrees;
    notifyListeners();
  }

  List<PieChartSectionData> plotPieChart(List<SessionModel> sessionList) {
    final Map<String, double> categoryTimeMap = {};
    Set<SessionDistributionModel> accumulatedSessions = {};

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
    totalHours = categoryTimeMap.values.reduce((a, b) => a + b);

    var result = categoryTimeMap.entries.map((entry) {
      final double percentage = (entry.value / totalHours) * 100;
      accumulatedSessions.add(
        SessionDistributionModel(
          categoryId: entry.key,
          name: entry.key,
          percentage: '${percentage.toStringAsFixed(1)}%',
          totalHours: entry.value,
        ),
      );

      return PieChartSectionData(
        color: getColorForCategory(entry.key),
        value: percentage,
        title: '${entry.key}: ${percentage.toStringAsFixed(1)}%',
        radius: 75,
        titleStyle: const TextStyle(
          fontSize: 11,
          fontFamily: "Barlow",
          fontWeight: FontWeight.bold,
          color: Color(0xffffffff),
        ),
      );
    }).toList();
    sessionDetailsList.clear();
    sessionDetailsList.addAll(accumulatedSessions);

    return result;
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
