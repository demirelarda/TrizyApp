import 'package:equatable/equatable.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsRequested extends ProductsEvent {
  final String? query;
  final String? categoryId;
  final int page;

  const ProductsRequested({
    required this.categoryId,
    required this.query,
    required this.page,
  });

  @override
  List<Object?> get props => [query, categoryId, page];
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