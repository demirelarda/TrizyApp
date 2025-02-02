import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/product/products_response.dart';
import '../../models/product/product_query_params.dart';

class ProductsState extends Equatable {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailure;
  final ProductsResponse? productsResponse;
  final String? errorMessage;
  final Set<String> likedProductIds;
  final Set<String> itemsInCart;
  final ProductQueryParams? queryParams;

  const ProductsState({
    required this.isLoading,
    required this.isSuccess,
    required this.isFailure,
    this.productsResponse,
    this.errorMessage,
    this.likedProductIds = const {},
    this.itemsInCart = const {},
    this.queryParams,
  });

  factory ProductsState.initial() {
    return const ProductsState(
      isLoading: false,
      isSuccess: false,
      isFailure: false,
      productsResponse: null,
      errorMessage: null,
      likedProductIds: {},
      itemsInCart: {},
      queryParams: null,
    );
  }

  ProductsState copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isFailure,
    ProductsResponse? productsResponse,
    String? errorMessage,
    Set<String>? likedProductIds,
    Set<String>? itemsInCart,
    ProductQueryParams? queryParams,
  }) {
    return ProductsState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isFailure: isFailure ?? this.isFailure,
      productsResponse: productsResponse ?? this.productsResponse,
      errorMessage: errorMessage ?? this.errorMessage,
      likedProductIds: likedProductIds ?? this.likedProductIds,
      itemsInCart: itemsInCart ?? this.itemsInCart,
      queryParams: queryParams ?? this.queryParams,
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
    queryParams,
  ];
}