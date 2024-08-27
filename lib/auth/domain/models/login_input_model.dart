import 'package:equatable/equatable.dart';

class LoginInputModel extends Equatable {
  const LoginInputModel({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [email, password];
}
