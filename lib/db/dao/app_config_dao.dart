import 'package:eco_focus/db/app_database.dart';
import 'package:eco_focus/models/app_config/app_config_model.dart';

class AppConfigDao {
  final AppDatabase appDatabase;

  AppConfigDao(this.appDatabase);

  Future<void> insertAppConfig(AppConfigModel appConfigModel) async {
    try {
      await appDatabase.db!.insert('AppConfig', appConfigModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }
}
