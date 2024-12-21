import '../cart.dart';

class DeleteItemFromCartResponse {
  final bool success;
  final String message;
  final List<CartItem> items;

  DeleteItemFromCartResponse({
    required this.success,
    required this.message,
    required this.items,
  });

  factory DeleteItemFromCartResponse.fromJson(Map<String, dynamic> json) {
    return DeleteItemFromCartResponse(
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