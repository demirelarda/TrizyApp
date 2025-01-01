import 'package:equatable/equatable.dart';

class SignOutState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String? errorMessage;

  const SignOutState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.errorMessage,
  });

  factory SignOutState.initial() {
    return const SignOutState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: null,
    );
  }

  SignOutState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
  }) {
    return SignOutState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, errorMessage];
}