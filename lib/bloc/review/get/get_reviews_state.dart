import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/review/get_reviews_response.dart';

class GetReviewsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final GetReviewsResponse? getReviewsResponse;
  final String? errorMessage;

  const GetReviewsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.getReviewsResponse,
    this.errorMessage,
  });

  factory GetReviewsState.initial() {
    return const GetReviewsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      getReviewsResponse: null,
      errorMessage: null,
    );
  }

  GetReviewsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    GetReviewsResponse? getReviewsResponse,
    String? errorMessage,
  }) {
    return GetReviewsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      getReviewsResponse: getReviewsResponse ?? this.getReviewsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, getReviewsResponse, errorMessage];
}