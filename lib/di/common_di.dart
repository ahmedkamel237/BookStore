import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:store_app/common/base/app_injector.dart';
import 'package:store_app/common/utils/network_info.dart';

class CommonDi {
  static Future<void> initialize() async {
    injector.registerLazySingleton(() => InternetConnectionChecker());
    injector.registerFactory<NetworkInfo>(() => NetworkInfoImpl(injector()));
    injector.registerFactory(() => CheckInternetConnectionUseCase(injector()));
  }
}
