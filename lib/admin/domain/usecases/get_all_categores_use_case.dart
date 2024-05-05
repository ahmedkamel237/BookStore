import 'package:stor_app/admin/domain/repository/admin_repository.dart';

class GetAllCategoriesUseCase {
  GetAllCategoriesUseCase(this._repository);

  final AdminRepository _repository;
  Future<List<String>> execute() async {
    final date =await _repository.fetchCategories();
    return date;
  }
}