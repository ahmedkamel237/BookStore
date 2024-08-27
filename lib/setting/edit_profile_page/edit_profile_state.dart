abstract class EditProfileState {}

class EditProfileInitial extends EditProfileState {}
class EditProfileSuccess extends EditProfileState {}
class EditProfileFailure extends EditProfileState {
  final String error;

  EditProfileFailure(this.error);
}
class EditProfileLoading extends EditProfileState {}
