abstract class ForgetPasswordState {
  final String? error;

  ForgetPasswordState([this.error]);
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {}

class ForgetPasswordFailure extends ForgetPasswordState {
  ForgetPasswordFailure(super.error);
}
