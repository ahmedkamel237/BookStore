import 'package:stor_app/admin/domain/repository/admin_repository.dart';

class AddCategoriesUseCase {
  AddCategoriesUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> execute(String collectionName) async {
    await _adminRepository.addCollection(collectionName);
  }
}
