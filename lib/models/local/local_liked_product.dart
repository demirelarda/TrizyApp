class LocalLikedProduct {
  final String productId;
  final DateTime? likedAt;

  LocalLikedProduct({
    required this.productId,
    this.likedAt,
  });

  factory LocalLikedProduct.fromMap(Map<String, dynamic> map) {
    return LocalLikedProduct(
      productId: map['productId'] as String,
      likedAt: map['likedAt'] != null ? DateTime.parse(map['likedAt']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'likedAt': likedAt?.toIso8601String(),
    };
  }
}