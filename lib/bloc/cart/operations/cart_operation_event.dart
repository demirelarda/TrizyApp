import 'package:equatable/equatable.dart';
import 'package:trizy_app/models/cart/request/add_item_to_cart_request.dart';

abstract class CartOperationEvent extends Equatable {
  const CartOperationEvent();

  @override
  List<Object?> get props => [];
}

class AddItemEvent extends CartOperationEvent {

  final AddItemToCartRequest request;

  const AddItemEvent({required this.request});

  @override
  List<Object?> get props => [request];

}


class DeleteItemEvent extends CartOperationEvent {

  final String productId;

  const DeleteItemEvent({required this.productId});

  @override
  List<Object?> get props => [productId];

}

class DecrementQuantityEvent extends CartOperationEvent {

  final String productId;

  const DecrementQuantityEvent({required this.productId});

  @override
  List<Object?> get props => [productId];

}