import '../cart.dart';

class AddItemToCartResponse {
  final bool success;
  final String message;
  final List<CartItem> items;
  final int? updatedQuantity;

  AddItemToCartResponse({
    required this.success,
    required this.message,
    required this.items,
    this.updatedQuantity,
  });

  factory AddItemToCartResponse.fromJson(Map<String, dynamic> json) {
    return AddItemToCartResponse(
      success: json['success'],
      message: json['message'],
      items: (json['cart']?['items'] ?? [])
          .map<CartItem>((item) => CartItem.fromJson(item))
          .toList(),
      updatedQuantity: json['updatedQuantity'],
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
    };
  }
}