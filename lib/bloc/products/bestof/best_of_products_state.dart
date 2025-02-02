import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/product/products_response.dart';

class BestOfProductsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final ProductsResponse? productsResponse;
  final String? errorMessage;
  final Set<String> likedProductIds;
  final Set<String> itemsInCart;

  const BestOfProductsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.productsResponse,
    this.errorMessage,
    this.likedProductIds = const {},
    this.itemsInCart = const {},
  });

  factory BestOfProductsState.initial() {
    return const BestOfProductsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      productsResponse: null,
      errorMessage: null,
      likedProductIds: {},
      itemsInCart: {},
    );
  }

  BestOfProductsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    ProductsResponse? productsResponse,
    String? errorMessage,
    Set<String>? likedProductIds,
    Set<String>? itemsInCart,
  }) {
    return BestOfProductsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      productsResponse: productsResponse ?? this.productsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      likedProductIds: likedProductIds ?? this.likedProductIds,
      itemsInCart: itemsInCart ?? this.itemsInCart,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    isSuccess,
    isFailure,
    productsResponse,
    errorMessage,
    likedProductIds,
    itemsInCart,
  ];
}