import 'package:eco_focus/db/app_database.dart';
import 'package:eco_focus/models/session/session_model.dart';

class SessionDao {
  final AppDatabase appDatabase;

  SessionDao(this.appDatabase);

  Future<void> addSession(SessionModel sessionModel) async {
    try {
      await appDatabase.db!.insert('SessionTable', sessionModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<SessionModel>?> getAllSession() async {
    try {
      List<Map<String, Object?>> result =
          await appDatabase.db!.rawQuery("SELECT * FROM SessionTable");
      if (result.isNotEmpty) {
        return result.map((a) => SessionModel.fromJson(a)).toList();
      }
    } catch (e) {
      throw Exception(e);
    }
    return null;
  }

  Future<SessionModel?> getSession(String id) async {
    try {
      List<Map<String, Object?>> result = await appDatabase.db!
          .rawQuery("SELECT * FROM SessionTable WHERE id = ?", [id]);
      if (result.isNotEmpty) {
        return SessionModel.fromJson(result.first);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
