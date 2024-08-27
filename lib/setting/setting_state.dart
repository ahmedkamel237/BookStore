import 'package:stor_app/auth/domain/models/user_data_model.dart';

abstract class SettingState {
  final String? error;

  SettingState([this.error]);

}

class SettingInitialState extends SettingState {}

class LogoutLoadingState extends SettingState {}

class LogoutSuccessState extends SettingState {}

class LogoutFailureState extends SettingState {

  LogoutFailureState(super.error);
}

class GetUserDataLoadingState extends SettingState {}

class GetUserDataSuccess extends SettingState {
  final UserDataModel userDataModel;

  GetUserDataSuccess(this.userDataModel);
}

class GetUserDataFailure extends SettingState {

  GetUserDataFailure(super.error);
}
