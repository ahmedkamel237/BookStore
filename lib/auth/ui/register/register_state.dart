abstract class RegisterState {
  final String? error;

  RegisterState([this.error]);
}

class RegisterInitial extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {}

class RegisterFailureState extends RegisterState {
  RegisterFailureState(super.error);
}
