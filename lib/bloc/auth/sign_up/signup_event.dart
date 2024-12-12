import 'package:equatable/equatable.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object?> get props => [];
}

class SignupSubmitted extends SignupEvent {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  const SignupSubmitted({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  @override
  List<Object?> get props => [email, firstName, lastName, password];
}