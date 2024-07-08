import 'package:eco_focus/db/dao/app_config_dao.dart';
import 'package:eco_focus/models/app_config/app_config_model.dart';
import 'package:eco_focus/repositories/app_config_repository.dart';

class AppConfigRepositoryImpl extends AppConfigRepository {
  final AppConfigDao appConfigDao;

  AppConfigRepositoryImpl({required this.appConfigDao});

  @override
  Future<void> insertAppConfig(AppConfigModel appConfigModel) async {
    try {
      await appConfigDao.insertAppConfig(appConfigModel);
    } catch (e) {
      throw Exception(e);
    }
  }
}
