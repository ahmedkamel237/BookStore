import 'package:stor_app/admin/domain/repository/admin_repository.dart';
import 'package:stor_app/home/domain/models/categoriey_model_input.dart';

class AddCategoriesUseCase {
  AddCategoriesUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> execute(CategoriesModelInput input) async {
    await _adminRepository.addCollection(input);
  }
}
