import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stor_app/common/constants/app_constants.dart';
import 'package:stor_app/home/data/mappers/home_mapper.dart';
import 'package:stor_app/home/data/model/api_categies_model.dart';
import 'package:stor_app/home/domain/models/categories_model.dart';
import 'package:stor_app/home/domain/repository/home_repository.dart';

class HomeRepositoryImp implements HomeRepository {
  final CollectionReference<Map<String, dynamic>> _categories =
      FirebaseFirestore.instance.collection(AppConstants.collectionName);

  @override
  Future<List<CategoriesModel>> getAllCategories() async {
    final result = await _categories.get();
    return result.docs
        .map((e) => ApiCategoryModel.fromJson(e.data()).toCategoriesModel())
        .toList();
  }
}
