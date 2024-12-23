import 'package:store_app/home/data/model/api_categies_model.dart';
import 'package:store_app/home/domain/models/categories_model.dart';

extension ConvertDocumentSnapshotToCategoriesModel on ApiCategoryModel {
  CategoriesModel toCategoriesModel() {
    return CategoriesModel(
      name: name ?? '',
      id: id ?? '',
      image: image ?? "assets/store_app_background.jpeg",
    );
  }
}
