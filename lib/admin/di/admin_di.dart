import 'package:stor_app/admin/data/repository/admin_repository_imp.dart';
import 'package:stor_app/admin/domain/repository/admin_repository.dart';
import 'package:stor_app/admin/domain/usecases/add_categories_use_case.dart';
import 'package:stor_app/admin/domain/usecases/remove_collection.dart';
import 'package:stor_app/common/base/app_injector.dart';

class AdminDi {
  static Future<void> initialize() async {
    injector.registerLazySingleton<AdminRepository>(
      () => AdminRepositoryImpl(),
    );
    injector.registerFactory(() => AddCategoriesUseCase(injector()));
    injector.registerFactory(() => RemoveCollectionUseCase(injector()));
  }
}
