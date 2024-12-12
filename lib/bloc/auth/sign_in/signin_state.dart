import 'package:equatable/equatable.dart';
import '../../../models/user/user_model.dart';

class SignInState extends Equatable {
  final bool isLoggingIn;
  final bool isSuccess;
  final bool isFailure;
  final User? user;
  final String? errorMessage;

  const SignInState({
    required this.isLoggingIn,
    required this.isSuccess,
    required this.isFailure,
    this.user,
    this.errorMessage,
  });

  factory SignInState.initial() {
    return const SignInState(
      isLoggingIn: false,
      isSuccess: false,
      isFailure: false,
      user: null,
      errorMessage: null,
    );
  }

  SignInState copyWith({
    bool? isLoggingIn,
    bool? isSuccess,
    bool? isFailure,
    User? user,
    String? errorMessage,
  }) {
    return SignInState(
      isLoggingIn: isLoggingIn ?? this.isLoggingIn,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoggingIn, isSuccess, isFailure, user, errorMessage];
}