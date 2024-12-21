class AddItemToCartRequest {
  final String productId;
  final int quantity;

  AddItemToCartRequest({
    required this.productId,
    required this.quantity,
  });

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'quantity': quantity,
    };
  }
}