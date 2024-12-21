import '../cart.dart';

class GetCartResponse {
  final bool success;
  final Cart cart;

  GetCartResponse({
    required this.success,
    required this.cart,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      success: json['success'],
      cart: Cart.fromJson(json['cart']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'cart': cart.toJson(),
    };
  }

  GetCartResponse copyWith({
    bool? success,
    Cart? cart,
  }) {
    return GetCartResponse(
      success: success ?? this.success,
      cart: cart ?? this.cart,
    );
  }
}