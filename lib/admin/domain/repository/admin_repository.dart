
import 'package:stor_app/home/domain/models/categoriey_model_input.dart';

abstract class AdminRepository {
  Future<void> addCollection(CategoriesModelInput input);
  Future<void> removeCollection(String id);
  // Future<CategoriesModel> updateCollection(CategoriesModel model);
}
