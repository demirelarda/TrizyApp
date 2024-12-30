import 'package:trizy_app/models/review/review_operation_response.dart';

enum ReviewOperation { none, create, delete }

class ReviewOperationState {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final String errorMessage;
  final ReviewOperationResponse? reviewOperationResponse;
  final ReviewOperation currentOperation;

  ReviewOperationState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    required this.errorMessage,
    required this.reviewOperationResponse,
    required this.currentOperation,
  });

  factory ReviewOperationState.initial() {
    return ReviewOperationState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      errorMessage: '',
      reviewOperationResponse: null,
      currentOperation: ReviewOperation.none,
    );
  }

  ReviewOperationState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    String? errorMessage,
    ReviewOperationResponse? reviewOperationResponse,
    ReviewOperation? currentOperation,
  }) {
    return ReviewOperationState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      errorMessage: errorMessage ?? this.errorMessage,
      reviewOperationResponse: reviewOperationResponse ?? this.reviewOperationResponse,
      currentOperation: currentOperation ?? this.currentOperation,
    );
  }
}