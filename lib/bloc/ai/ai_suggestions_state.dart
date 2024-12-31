import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/product/products_response.dart';

class AiSuggestionsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final ProductsResponse? productsResponse;
  final String? errorMessage;

  const AiSuggestionsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.productsResponse,
    this.errorMessage,
  });

  factory AiSuggestionsState.initial() {
    return const AiSuggestionsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      productsResponse: null,
      errorMessage: null,
    );
  }

  AiSuggestionsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    ProductsResponse? productsResponse,
    String? errorMessage,
  }) {
    return AiSuggestionsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      productsResponse: productsResponse ?? this.productsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, productsResponse, errorMessage];
}