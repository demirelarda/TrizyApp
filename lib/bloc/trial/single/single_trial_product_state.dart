import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/trialproduct/single_trial_product_response.dart';

class SingleTrialProductState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final SingleTrialProductResponse? singleTrialProductResponse;
  final String? errorMessage;

  const SingleTrialProductState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.singleTrialProductResponse,
    this.errorMessage,
  });

  factory SingleTrialProductState.initial() {
    return const SingleTrialProductState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      singleTrialProductResponse: null,
      errorMessage: null,
    );
  }

  SingleTrialProductState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    SingleTrialProductResponse? singleTrialProductResponse,
    String? errorMessage,
  }) {
    return SingleTrialProductState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      singleTrialProductResponse: singleTrialProductResponse ?? this.singleTrialProductResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, singleTrialProductResponse, errorMessage];
}