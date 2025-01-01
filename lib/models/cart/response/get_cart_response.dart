import '../cart.dart';

class GetCartResponse {
  final bool success;
  final Cart cart;
  final double cargoFeeThreshold;

  GetCartResponse({
    required this.success,
    required this.cart,
    required this.cargoFeeThreshold,
  });

  factory GetCartResponse.fromJson(Map<String, dynamic> json) {
    return GetCartResponse(
      success: json['success'],
      cart: Cart.fromJson(json['cart']),
      cargoFeeThreshold: (json['cargoFeeThreshold'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'cart': cart.toJson(),
      'cargoFeeThreshold': cargoFeeThreshold,
    };
  }

  GetCartResponse copyWith({
    bool? success,
    Cart? cart,
    double? cargoFeeThreshold,
  }) {
    return GetCartResponse(
      success: success ?? this.success,
      cart: cart ?? this.cart,
      cargoFeeThreshold: cargoFeeThreshold ?? this.cargoFeeThreshold,
    );
  }
}