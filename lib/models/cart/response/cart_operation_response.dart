import '../cart.dart';

class CartOperationResponse {
  final bool success;
  final String message;
  final List<CartItem> items;
  final int? updatedQuantity; // only for Add Item responses
  final CartOperationType operationType; // to differentiate operation type

  CartOperationResponse({
    required this.success,
    required this.message,
    required this.items,
    this.updatedQuantity,
    required this.operationType,
  });

  factory CartOperationResponse.fromJson(Map<String, dynamic> json, CartOperationType operationType) {
    return CartOperationResponse(
      success: json['success'],
      message: json['message'],
      items: (json['cart']?['items'] ?? [])
          .map<CartItem>((item) => CartItem.fromJson(item))
          .toList(),
      updatedQuantity: json['updatedQuantity'],
      operationType: operationType,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'cart': {
        'items': items.map((item) => item.toJson()).toList(),
      },
      'updatedQuantity': updatedQuantity,
      'operationType': operationType.name,
    };
  }
}

enum CartOperationType {
  addItem,
  decrementQuantity,
  deleteItem,
}