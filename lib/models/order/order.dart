class OrderData {
  final String id;
  final String userId;
  final String paymentIntentId;
  final double amount;
  final String currency;
  final String status;
  final List<OrderItem> items;
  final DateTime createdAt;

  OrderData({
    required this.id,
    required this.userId,
    required this.paymentIntentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.items,
    required this.createdAt,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['_id'],
      userId: json['userId'],
      paymentIntentId: json['paymentIntentId'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      status: json['status'],
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'paymentIntentId': paymentIntentId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class OrderItem {
  final String id;
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['_id'],
      productId: json['productId'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}