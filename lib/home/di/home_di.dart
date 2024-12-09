import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/home/data/repository/home_repository_imp.dart';
import 'package:store_app/home/domain/repository/home_repository.dart';
import 'package:store_app/home/domain/use_cases/get_all_categores_use_case.dart';
import 'package:store_app/home/domain/use_cases/get_all_product_use_case.dart';

class HomeDi {
  static Future<void> initialize() async {
    injector.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImp(),
    );
    injector.registerFactory(() => GetAllCategoriesUseCase(injector()));
    injector.registerFactory(() => GetAllProductUseCase(homeRepository: injector()));
  }
}
