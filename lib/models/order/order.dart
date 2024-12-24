class OrderData {
  final String userId;
  final String paymentIntentId;
  final double amount;
  final String currency;
  final String status;
  final List<OrderItem> items;

  OrderData({
    required this.userId,
    required this.paymentIntentId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.items,
  });

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      userId: json['userId'],
      paymentIntentId: json['paymentIntentId'],
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'],
      status: json['status'],
      items: (json['items'] as List<dynamic>)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'paymentIntentId': paymentIntentId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class OrderItem {
  final String productId;
  final int quantity;
  final double price;

  OrderItem({
    required this.productId,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      productId: json['productId'],
      quantity: json['quantity'],
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
      'price': price,
    };
  }
}