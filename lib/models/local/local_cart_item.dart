class LocalCartItem {
  final String productId;

  LocalCartItem({required this.productId});

  factory LocalCartItem.fromMap(Map<String, dynamic> map) {
    return LocalCartItem(
      productId: map['productId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
    };
  }
}