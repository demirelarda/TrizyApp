class OrderDetailsResponse {
  final bool success;
  final OrderDetails order;

  OrderDetailsResponse({required this.success, required this.order});

  factory OrderDetailsResponse.fromJson(Map<String, dynamic> json) {
    return OrderDetailsResponse(
      success: json['success'],
      order: OrderDetails.fromJson(json['order']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'order': order.toJson(),
    };
  }
}

class OrderDetails {
  final String orderId;
  final double amount;
  final String currency;
  final String status;
  final DateTime createdAt;
  final DeliveryAddressDetails deliveryAddress;
  final List<OrderItemDetails> items;

  OrderDetails({
    required this.orderId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.deliveryAddress,
    required this.items,
  });

  factory OrderDetails.fromJson(Map<String, dynamic> json) {
    return OrderDetails(
      orderId: json['orderId'],
      amount: json['amount'].toDouble(),
      currency: json['currency'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      deliveryAddress: DeliveryAddressDetails.fromJson(json['deliveryAddress']),
      items: (json['items'] as List)
          .map((item) => OrderItemDetails.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'amount': amount,
      'currency': currency,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'deliveryAddress': deliveryAddress.toJson(),
      'items': items.map((item) => item.toJson()).toList(),
    };
  }
}

class DeliveryAddressDetails {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;

  DeliveryAddressDetails({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
  });

  factory DeliveryAddressDetails.fromJson(Map<String, dynamic> json) {
    return DeliveryAddressDetails(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
    };
  }
}

class OrderItemDetails {
  final String productId;
  final String productTitle;
  final String productImage;
  final int quantity;
  final double price;

  OrderItemDetails({
    required this.productId,
    required this.productTitle,
    required this.productImage,
    required this.quantity,
    required this.price,
  });

  factory OrderItemDetails.fromJson(Map<String, dynamic> json) {
    return OrderItemDetails(
      productId: json['productId'],
      productTitle: json['productTitle'],
      productImage: json['productImage'],
      quantity: json['quantity'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productTitle': productTitle,
      'productImage': productImage,
      'quantity': quantity,
      'price': price,
    };
  }
}