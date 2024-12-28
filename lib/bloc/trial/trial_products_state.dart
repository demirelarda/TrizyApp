import 'package:equatable/equatable.dart';
import '../../models/trialproduct/trial_products_response.dart';

class TrialProductsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final TrialProductsResponse? trialProductsResponse;
  final String? errorMessage;

  const TrialProductsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.trialProductsResponse,
    this.errorMessage,
  });

  factory TrialProductsState.initial() {
    return const TrialProductsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      trialProductsResponse: null,
      errorMessage: null,
    );
  }

  TrialProductsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    TrialProductsResponse? trialProductsResponse,
    String? errorMessage,
  }) {
    return TrialProductsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      trialProductsResponse: trialProductsResponse ?? this.trialProductsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, trialProductsResponse, errorMessage];
}