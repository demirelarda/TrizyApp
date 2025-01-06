class CheckOrderStatusResponse {
  final bool success;
  final String message;
  final UserOrder? order;

  CheckOrderStatusResponse({
    required this.success,
    required this.message,
    this.order,
  });

  factory CheckOrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return CheckOrderStatusResponse(
      success: json['success'],
      message: json['message'],
      order: json['order'] != null ? UserOrder.fromJson(json['order']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'order': order?.toJson(),
    };
  }
}

class UserOrder {
  final String id;
  final String userId;
  final String deliveryAddress;
  final String paymentIntentId;
  final double amount;
  final String currency;
  final String status;
  final List<UserOrderItem> items;
  final DateTime createdAt;

  UserOrder({
    required this.id,
    required this.userId,
    required this.deliveryAddress,
    required this.paymentIntentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.items,
    required this.createdAt,
  });

  factory UserOrder.fromJson(Map<String, dynamic> json) {
    return UserOrder(
      id: json['_id'],
      userId: json['userId'],
      deliveryAddress: json['deliveryAddress'],
      paymentIntentId: json['paymentIntentId'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      status: json['status'],
      items: (json['items'] as List)
          .map((item) => UserOrderItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'deliveryAddress': deliveryAddress,
      'paymentIntentId': paymentIntentId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class UserOrderItem {
  final String productId;
  final int quantity;
  final double price;
  final String id;

  UserOrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
    required this.id,
  });

  factory UserOrderItem.fromJson(Map<String, dynamic> json) {
    return UserOrderItem(
      productId: json['productId'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
      id: json['_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
      '_id': id,
    };
  }
}