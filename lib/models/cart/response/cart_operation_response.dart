import '../cart.dart';

class CartOperationResponse {
  final bool success;
  final String message;
  final Cart cart;
  final double cargoFeeThreshold;

  CartOperationResponse({
    required this.success,
    required this.message,
    required this.cart,
    required this.cargoFeeThreshold,
  });

  factory CartOperationResponse.fromJson(Map<String, dynamic> json) {
    return CartOperationResponse(
      success: json['success'],
      message: json['message'],
      cart: Cart.fromJson(json['cart']),
      cargoFeeThreshold: (json['cargoFeeThreshold'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'cart': cart.toJson(),
      'cargoFeeThreshold': cargoFeeThreshold,
    };
  }
}