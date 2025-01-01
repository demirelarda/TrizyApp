class Cart {
  final String ownerId;
  final List<CartItem> items;
  final DateTime updatedAt;
  final double cargoFee;

  Cart({
    required this.ownerId,
    required this.items,
    required this.updatedAt,
    required this.cargoFee,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      ownerId: json['ownerId'],
      items: (json['items'] as List)
          .map((item) => CartItem.fromJson(item))
          .toList(),
      updatedAt: DateTime.parse(json['updatedAt']),
      cargoFee: (json['cargoFee'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'items': items.map((item) => item.toJson()).toList(),
      'updatedAt': updatedAt.toIso8601String(),
      'cargoFee': cargoFee,
    };
  }
}

class CartItem {
  final String productId;
  final String title;
  final String? imageURL;
  final double cargoWeight;
  final int stockCount;
  final double price;
  final int quantity;

  CartItem({
    required this.productId,
    required this.title,
    required this.imageURL,
    required this.cargoWeight,
    required this.stockCount,
    required this.price,
    required this.quantity,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      productId: json['productId'],
      title: json['title'],
      imageURL: json['imageURL'],
      cargoWeight: (json['cargoWeight'] as num).toDouble(),
      stockCount: json['stockCount'],
      price: (json['price'] as num).toDouble(),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'title': title,
      'imageURL': imageURL,
      'cargoWeight': cargoWeight,
      'stockCount': stockCount,
      'price': price,
      'quantity': quantity,
    };
  }
}