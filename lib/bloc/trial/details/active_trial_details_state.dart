import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/trial/get_active_trial_response.dart';

class ActiveTrialDetailsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final GetActiveTrialResponse? getActiveTrialResponse;
  final String? errorMessage;

  const ActiveTrialDetailsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.getActiveTrialResponse,
    this.errorMessage,
  });

  factory ActiveTrialDetailsState.initial() {
    return const ActiveTrialDetailsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      getActiveTrialResponse: null,
      errorMessage: null,
    );
  }

  ActiveTrialDetailsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    GetActiveTrialResponse? getActiveTrialResponse,
    String? errorMessage,
  }) {
    return ActiveTrialDetailsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      getActiveTrialResponse: getActiveTrialResponse ?? this.getActiveTrialResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, getActiveTrialResponse, errorMessage];
}