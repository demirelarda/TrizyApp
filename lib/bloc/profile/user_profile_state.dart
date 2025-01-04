import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/user/user_profile_response.dart';

class UserProfileState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final UserProfileResponse? userProfileResponse;
  final String? errorMessage;

  const UserProfileState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.userProfileResponse,
    this.errorMessage,
  });

  factory UserProfileState.initial() {
    return const UserProfileState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      userProfileResponse: null,
      errorMessage: null,
    );
  }

  UserProfileState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    UserProfileResponse? userProfileResponse,
    String? errorMessage,
  }) {
    return UserProfileState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      userProfileResponse: userProfileResponse ?? this.userProfileResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, userProfileResponse, errorMessage];
}