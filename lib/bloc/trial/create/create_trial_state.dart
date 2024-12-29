import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/trial/create_trial_response.dart';

class CreateTrialState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final CreateTrialResponse? createTrialResponse;
  final String? errorMessage;

  const CreateTrialState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.createTrialResponse,
    this.errorMessage,
  });

  factory CreateTrialState.initial() {
    return const CreateTrialState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      createTrialResponse: null,
      errorMessage: null,
    );
  }

  CreateTrialState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    CreateTrialResponse? createTrialResponse,
    String? errorMessage,
  }) {
    return CreateTrialState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      createTrialResponse: createTrialResponse ?? this.createTrialResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, createTrialResponse, errorMessage];
}