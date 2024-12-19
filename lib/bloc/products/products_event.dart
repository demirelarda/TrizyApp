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
    required this.page
  });

  @override
  List<Object?> get props => [query, categoryId, page];

}