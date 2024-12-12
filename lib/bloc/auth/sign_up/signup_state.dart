import 'package:equatable/equatable.dart';
import '../../../models/user/user_model.dart';

class SignupState extends Equatable {
  final bool isSubmitting;
  final bool isSuccess;
  final bool isFailure;
  final User? user;
  final String? errorMessage;

  const SignupState({
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure,
    this.user,
    this.errorMessage,
  });

  factory SignupState.initial() {
    return const SignupState(
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
      user: null,
      errorMessage: null,
    );
  }

  SignupState copyWith({
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
    User? user,
    String? errorMessage,
  }) {
    return SignupState(
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isSubmitting, isSuccess, isFailure, user, errorMessage];
}