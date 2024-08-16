import 'package:eco_focus/models/session/session_model.dart';
import 'package:flutter/material.dart';

class SessionListViewModel extends ChangeNotifier {
  String highestSession = '';
  String lowestSession = '';

  analyseSessions(List<SessionModel> sessionList) {
    final Map<String, double> categoryTimeMap = {};

    // Accumulate session category into map
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
    var highestValue = categoryTimeMap.values.reduce((a, b) => a > b ? a : b);
    var lowestValue = categoryTimeMap.values.reduce((a, b) => a < b ? a : b);
    highestSession =
        categoryTimeMap.entries.firstWhere((e) => e.value == highestValue).key;
    lowestSession =
        categoryTimeMap.entries.firstWhere((e) => e.value == lowestValue).key;
    notifyListeners();
  }
}
