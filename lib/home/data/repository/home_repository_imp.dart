import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app/common/constants/app_constants.dart';
import 'package:store_app/home/data/mappers/category_mapper.dart';
import 'package:store_app/home/data/mappers/product_mapper.dart';
import 'package:store_app/home/data/model/api_categies_model.dart';
import 'package:store_app/home/data/model/api_product_model.dart';
import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/models/product_model.dart';
import 'package:store_app/home/domain/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final CollectionReference<Map<String, dynamic>> _categories;

  HomeRepositoryImp(this._categories);

  @override
  Future<List<CategoriesModel>> getAllCategories() async {
    final result = await _categories
        .get()
        .then((value) => value)
        .catchError((e) => throw Exception(e));
    return result.docs
        .map((e) => ApiCategoryModel.fromJson(e.data()).toCategoriesModel())
        .toList();
  }

  @override
  Future<List<ProductModel>> getAllProducts(String categoryId) async {
    final result = await _categories
        .doc(categoryId)
        .collection(AppConstants.productCollection)
        .get()
        .catchError((e) => throw Exception(e));
    return result.docs
        .map((e) => ApiProductModel.fromJson(e.data()).mapTo())
        .toList();
  }
}
