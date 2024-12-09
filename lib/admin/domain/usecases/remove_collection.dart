import 'package:store_app/admin/domain/repository/admin_repository.dart';

class RemoveCollectionUseCase {
  RemoveCollectionUseCase(this._adminRepository);

  final AdminRepository _adminRepository;

  Future<void> execute(String id) async {
    await _adminRepository.removeCollection(id);
  }
}