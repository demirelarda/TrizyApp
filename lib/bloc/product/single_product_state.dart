import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/product/single_product_response.dart';

class SingleProductState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final SingleProductResponse? productResponse;
  final String? errorMessage;

  const SingleProductState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.productResponse,
    this.errorMessage,
  });

  factory SingleProductState.initial() {
    return const SingleProductState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      productResponse: null,
      errorMessage: null,
    );
  }

  SingleProductState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    SingleProductResponse? productResponse,
    String? errorMessage,
  }) {
    return SingleProductState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      productResponse: productResponse ?? this.productResponse,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, productResponse, errorMessage];
}