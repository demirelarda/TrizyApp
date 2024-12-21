import 'package:equatable/equatable.dart';

abstract class AddCartItemOnFeedEvent extends Equatable {
  const AddCartItemOnFeedEvent();

  @override
  List<Object?> get props => [];
}

class AddFeedItemEvent extends AddCartItemOnFeedEvent {

  final String productId;

  const AddFeedItemEvent({required this.productId});

  @override
  List<Object?> get props => [productId];

}
