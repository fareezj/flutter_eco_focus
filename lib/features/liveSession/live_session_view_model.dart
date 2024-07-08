import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';
import 'package:flutter/material.dart';

class LiveSessionViewModel extends ChangeNotifier {
  final SessionRepository sessionRepository;

  LiveSessionViewModel({required this.sessionRepository});

  Future<void> saveSession(SessionModel sessionModel) async {
    try {
      await sessionRepository.addSession(sessionModel);
    } catch (e) {
      throw Exception(e);
    }
  }
}
