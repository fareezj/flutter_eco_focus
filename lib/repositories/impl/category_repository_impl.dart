import 'package:eco_focus/db/dao/category_dao.dart';
import 'package:eco_focus/models/category/category_model.dart';
import 'package:eco_focus/repositories/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryDao categoryDao;

  CategoryRepositoryImpl(this.categoryDao);

  @override
  Future<CategoryModel?> getCategory(String id) async {
    try {
      return await categoryDao.getCategory(id);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> insertCategory(CategoryModel categoryModel) async {
    try {
      await categoryDao.addCategory(categoryModel);
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<List<CategoryModel>?> getAllCategory() async {
    try {
      return await categoryDao.getAllCategory();
    } catch (e) {
      throw Exception(e);
    }
  }
}
