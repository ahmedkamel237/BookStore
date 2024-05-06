import 'package:stor_app/admin/domain/repository/admin_repository.dart';
import 'package:stor_app/home/domain/models/categories_model.dart';

class AddCategoriesUseCase {
  AddCategoriesUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> execute(CategoriesModel model) async {
    await _adminRepository.addCollection(model);
  }
}
