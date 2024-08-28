import 'package:stor_app/auth/domain/models/user_data_model.dart';

abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class EditProfileSuccess extends EditProfileState {
  final UserDataModel userDataModel;

  EditProfileSuccess(this.userDataModel);
}
class EditProfileFailure extends EditProfileState {
  final String error;

  EditProfileFailure(this.error);
}
class EditProfileLoading extends EditProfileState {}
