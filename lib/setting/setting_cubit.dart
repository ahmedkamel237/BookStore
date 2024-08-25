import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor_app/auth/domain/models/user_data_model.dart';
import 'package:stor_app/auth/domain/usecases/get_user_data_use_case.dart';
import 'package:stor_app/auth/domain/usecases/logout_use_case.dart';
import 'package:stor_app/common/base/app_injector.dart';
import 'package:stor_app/setting/setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  late final LogOutUseCase _logOutUseCase;
  late final GetUserDataUseCase _getUserDataUseCase;

  SettingCubit() : super(SettingInitialState()) {
    _loadUseCases();
  }

  void _loadUseCases() {
    _logOutUseCase = injector();
    _getUserDataUseCase = injector();
  }

  Future<void> logOut() async {
    emit(LogoutLoadingState());
    try {
      await _logOutUseCase.execute();
      emit(LogoutSuccessState());
    } catch (e) {
      emit(LogoutFailureState(e.toString()));
    }
  }

  Future<UserDataModel> getUserData() async {
    emit(GetUserDataLoadingState());
    try {
      final userDataModel = await _getUserDataUseCase.execute();
      emit(GetUserDataSuccess(userDataModel));
      return userDataModel;
    } catch (e) {
      emit(GetUserDataFailure(e.toString()));
      rethrow;
    }
  }
}
