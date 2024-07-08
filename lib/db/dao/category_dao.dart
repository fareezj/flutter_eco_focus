import 'package:eco_focus/db/app_database.dart';
import 'package:eco_focus/models/category/category_model.dart';

class CategoryDao {
  final AppDatabase appDatabase;

  CategoryDao(this.appDatabase);

  Future<void> addCategory(CategoryModel categoryModel) async {
    try {
      await appDatabase.db!.insert('CategoryTable', categoryModel.toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<CategoryModel?> getCategory(String id) async {
    try {
      List<Map<String, Object?>> result = await appDatabase.db!
          .rawQuery("SELECT * FROM CategoryTable WHERE id = ?", [id]);
      if (result.isNotEmpty) {
        return CategoryModel.fromJson(result.first);
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<List<CategoryModel>?> getAllCategory() async {
    try {
      List<Map<String, Object?>> result =
          await appDatabase.db!.rawQuery("SELECT * FROM CategoryTable");
      if (result.isNotEmpty) {
        return result.map((a) => CategoryModel.fromJson(a)).toList();
      }
      return null;
    } catch (e) {
      throw Exception(e);
    }
  }
}
