
import 'package:stor_app/home/domain/models/categories_model.dart';

abstract class AdminRepository {
  Future<void> addCollection(CategoriesModel model);
  Future<void> removeCollection(String id);
  // Future<CategoriesModel> updateCollection(CategoriesModel model);
}
