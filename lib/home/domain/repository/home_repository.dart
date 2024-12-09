import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/models/product_model.dart';

abstract class HomeRepository {
  Future<List<CategoriesModel>> getAllCategories();

  Future<List<ProductModel>> getAllProducts(String categoryId);
}
