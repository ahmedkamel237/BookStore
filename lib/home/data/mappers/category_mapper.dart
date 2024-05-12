import 'package:stor_app/home/data/model/api_categies_model.dart';
import 'package:stor_app/home/data/model/api_product_model.dart';
import 'package:stor_app/home/domain/models/categories_model.dart';
import 'package:stor_app/home/domain/models/product_model.dart';

extension ConvertDocumentSnapshotToCategoriesModel on ApiCategoryModel {
  CategoriesModel toCategoriesModel() {
    return CategoriesModel(
      name: name ?? '',
      id: id ?? '',
      image: image ?? '',
    );
  }
}
