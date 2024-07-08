import 'package:eco_focus/models/category/category_model.dart';

abstract class CategoryRepository {
  Future<void> insertCategory(CategoryModel categoryModel);
  Future<CategoryModel?> getCategory(String id);
  Future<List<CategoryModel>?> getAllCategory();
}
