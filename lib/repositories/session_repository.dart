import 'package:eco_focus/models/session/session_model.dart';

abstract class SessionRepository {
  Future<void> addSession(SessionModel sessionModel);
  Future<SessionModel?> getSession(String id);
  Future<List<SessionModel>?> getAllSession();
}
