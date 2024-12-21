import '../cart.dart';

class DecrementQuantityResponse {
  final bool success;
  final String message;
  final List<CartItem> items;

  DecrementQuantityResponse({
    required this.success,
    required this.message,
    required this.items,
  });

  factory DecrementQuantityResponse.fromJson(Map<String, dynamic> json) {
    return DecrementQuantityResponse(
      success: json['success'],
      message: json['message'],
      items: (json['cart']['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'cart': {
        'items': items.map((item) => item.toJson()).toList(),
      },
    };
  }
}