import 'package:equatable/equatable.dart';

abstract class BestOfProductsEvent extends Equatable {
  const BestOfProductsEvent();

  @override
  List<Object?> get props => [];
}

class BestProductsRequested extends BestOfProductsEvent {
  final String period;

  const BestProductsRequested({
    required this.period,
  });

  @override
  List<Object?> get props => [period];
}

class BestOfFetchLikedProductsFromLocal extends BestOfProductsEvent {}

class BestOfFetchCartItemsFromLocal extends BestOfProductsEvent {}

class BestOfAddLikeEvent extends BestOfProductsEvent {
  final String productId;

  const BestOfAddLikeEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}

class BestOfRemoveLikeEvent extends BestOfProductsEvent {
  final String productId;

  const BestOfRemoveLikeEvent({required this.productId});

  @override
  List<Object?> get props => [productId];
}
