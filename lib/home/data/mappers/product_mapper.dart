import 'package:store_app/home/data/model/api_product_model.dart';
import 'package:store_app/home/domain/models/product_model.dart';

extension ConvertCategoriesModelToDocumentSnapshot on ApiProductModel {
  ProductModel mapTo() {
    return ProductModel(
      name: name ??'',
      id: id??'',
      image: image??[],
      price: price??0.0,
      description: description??'',
    );
  }
}