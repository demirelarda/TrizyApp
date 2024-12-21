import '../cart.dart';

class CartOperationResponse {
  final bool success;
  final String message;
  final Cart cart;

  CartOperationResponse({
    required this.success,
    required this.message,
    required this.cart,
  });

  factory CartOperationResponse.fromJson(Map<String, dynamic> json) {
    return CartOperationResponse(
      success: json['success'],
      message: json['message'],
      cart: Cart.fromJson(json['cart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'cart': cart.toJson(),
    };
  }
}