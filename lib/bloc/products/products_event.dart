import 'package:equatable/equatable.dart';

import '../../models/product/product_query_params.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsRequested extends ProductsEvent {
  final String? query;
  final String? categoryId;
  final int page;
  final ProductQueryParams? queryParams;

  const ProductsRequested({
    this.query,
    this.categoryId,
    required this.page,
    this.queryParams,
  });

  @override
  List<Object?> get props => [query, categoryId, page, queryParams];
}

class FetchLikedProductsFromLocal extends ProductsEvent {}

class FetchCartItemsFromLocal extends ProductsEvent {}

class AddLikeEvent extends ProductsEvent {
  final String productId;

  const AddLikeEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class RemoveLikeEvent extends ProductsEvent {
  final String productId;

  const RemoveLikeEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class LikedProductsRequested extends ProductsEvent {
  final int page;

  const LikedProductsRequested({
    required this.page,
  });

  @override
  List<Object?> get props => [page];
}