import 'package:equatable/equatable.dart';

class UserDataModel extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  const UserDataModel({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  List<Object?> get props => [firstName, lastName, email];
}