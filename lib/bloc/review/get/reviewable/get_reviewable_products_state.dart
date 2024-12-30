import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/review/get_reviewable_products_response.dart';

class GetReviewableProductsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final GetReviewableProductsResponse? getReviewableProductsResponse;
  final String? errorMessage;

  const GetReviewableProductsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.getReviewableProductsResponse,
    this.errorMessage,
  });

  factory GetReviewableProductsState.initial() {
    return const GetReviewableProductsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      getReviewableProductsResponse: null,
      errorMessage: null,
    );
  }

  GetReviewableProductsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    GetReviewableProductsResponse? getReviewableProductsResponse,
    String? errorMessage,
  }) {
    return GetReviewableProductsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      getReviewableProductsResponse: getReviewableProductsResponse ?? this.getReviewableProductsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, getReviewableProductsResponse, errorMessage];
}