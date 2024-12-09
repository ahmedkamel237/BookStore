import 'package:store_app/home/domain/models/categories_model.dart';
import 'package:store_app/home/domain/repository/home_repository.dart';

class GetAllCategoriesUseCase {
  GetAllCategoriesUseCase(this._repository);

  final HomeRepository _repository;
  Future<List<CategoriesModel>> execute() async {
    final date =await _repository.getAllCategories();
    return date;
  }
}
