import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/product/single_product_response.dart';

class SingleProductState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final SingleProductResponse? productResponse;
  final String? errorMessage;
  final bool isItemInCart;

  const SingleProductState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.productResponse,
    this.errorMessage,
    required this.isItemInCart,
  });

  factory SingleProductState.initial() {
    return const SingleProductState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      productResponse: null,
      errorMessage: null,
      isItemInCart: false,
    );
  }

  SingleProductState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    SingleProductResponse? productResponse,
    String? errorMessage,
    bool? isItemInCart,
  }) {
    return SingleProductState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      productResponse: productResponse ?? this.productResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      isItemInCart: isItemInCart ?? this.isItemInCart,
    );
  }

  @override
  List<Object?> get props => [isLoading, isSuccess, isFailure, productResponse, errorMessage, isItemInCart];
}