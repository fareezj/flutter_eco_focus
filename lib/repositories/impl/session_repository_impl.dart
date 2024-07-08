import 'package:eco_focus/db/dao/session_dao.dart';
import 'package:eco_focus/models/session/session_model.dart';
import 'package:eco_focus/repositories/session_repository.dart';

class SessionRepositoryImpl extends SessionRepository {
  final SessionDao sessionDao;

  SessionRepositoryImpl(this.sessionDao);

  @override
  Future<void> addSession(SessionModel sessionModel) async {
    try {
      await sessionDao.addSession(sessionModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<SessionModel>?> getAllSession() async {
    try {
      return await sessionDao.getAllSession();
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<SessionModel?> getSession(String id) async {
    try {
      return await sessionDao.getSession(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}
