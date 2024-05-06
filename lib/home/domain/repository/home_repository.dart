import 'package:stor_app/home/domain/models/categories_model.dart';

abstract class HomeRepository {
  Future<List<CategoriesModel>> getAllCategories();
}
