import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/constants/app_constants.dart';
import 'package:store_app/home/data/repository/home_repository_imp.dart';
import 'package:store_app/home/domain/repository/home_repository.dart';
import 'package:store_app/home/domain/use_cases/get_all_categores_use_case.dart';
import 'package:store_app/home/domain/use_cases/get_all_product_use_case.dart';

class HomeDi {
  static Future<void> initialize() async {
    final CollectionReference<Map<String, dynamic>> categories =
        FirebaseFirestore.instance.collection(AppConstants.collectionName);
    injector.registerLazySingleton<CollectionReference<Map<String, dynamic>>>(
      () => categories,
    );
    injector.registerLazySingleton<HomeRepository>(
      () => HomeRepositoryImp(injector()),
    );
    injector.registerFactory(() => GetAllCategoriesUseCase(injector()));
    injector.registerFactory(() => GetAllProductUseCase(homeRepository: injector()));
  }
}
