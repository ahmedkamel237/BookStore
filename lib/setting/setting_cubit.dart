import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/auth/domain/usecases/get_user_data_use_case.dart';
import 'package:stor_app/auth/domain/usecases/logout_use_case.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/common/utils/network_info.dart';
import 'package:stor_app/setting/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  late final LogOutUseCase _logOutUseCase;
  late final GetUserDataUseCase _getUserDataUseCase;
  late final CheckInternetConnectionUseCase _networkConnectionUseCase;

  SettingCubit() : super(SettingInitialState()) {
    _loadUseCases();
  }

  void _loadUseCases() {
    _logOutUseCase = injector();
    _getUserDataUseCase = injector();
    _networkConnectionUseCase = injector();
  }
  Future<void> logout() async {
    emit(LogoutLoadingState());
    if (!await _networkConnectionUseCase.execute()) {
      emit(LogoutFailureState('No internet connection'));
    }else {
      try {
        await _logOutUseCase.execute();
        emit(LogoutSuccessState());
      } catch (e) {
        emit(LogoutFailureState(e.toString()));
      }
    }

  }

  Future<void> getUserData() async {
    emit(GetUserDataLoadingState());
    if (!await _networkConnectionUseCase.execute()) {
      emit(GetUserDataFailure('No internet connection'));
    }else {
      try {
        final userDataModel = await _getUserDataUseCase.execute();
        emit(GetUserDataSuccess(userDataModel));
        return;
      } catch (e) {
        emit(GetUserDataFailure(e.toString()));
        emit(SettingInitialState());
      }
    }
  }
}
