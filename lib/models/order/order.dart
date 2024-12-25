class OrderData {
  final String id;
  final String userId;
  final DeliveryAddress deliveryAddress;
  final String paymentIntentId;
  final int amount;
  final String currency;
  final String status;
  final List<OrderItem> items;
  final DateTime createdAt;

  OrderData({
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

  factory OrderData.fromJson(Map<String, dynamic> json) {
    return OrderData(
      id: json['_id'],
      userId: json['userId'],
      deliveryAddress:
      DeliveryAddress.fromJson(json['deliveryAddress']),
      paymentIntentId: json['paymentIntentId'],
      amount: json['amount'],
      currency: json['currency'],
      status: json['status'],
      items: (json['items'] as List)
          .map((item) => OrderItem.fromJson(item))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'deliveryAddress': deliveryAddress.toJson(),
      'paymentIntentId': paymentIntentId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'items': items.map((item) => item.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class DeliveryAddress {
  final String id;
  final String address;
  final String city;
  final String state;
  final String country;

  DeliveryAddress({
    required this.id,
    required this.address,
    required this.city,
    required this.state,
    required this.country,
  });

  factory DeliveryAddress.fromJson(Map<String, dynamic> json) {
    return DeliveryAddress(
      id: json['_id'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'address': address,
      'city': city,
      'state': state,
      'country': country,
    };
  }
}

class OrderItem {
  final String id;
  final String productId;
  final List<String> imageURLs;
  final String title;
  final int quantity;
  final int price;

  OrderItem({
    required this.id,
    required this.productId,
    required this.imageURLs,
    required this.title,
    required this.quantity,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      id: json['_id'],
      productId: json['productId']['_id'],
      imageURLs: List<String>.from(json['productId']['imageURLs']),
      title: json['productId']['title'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'productId': productId,
      'imageURLs': imageURLs,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }
}