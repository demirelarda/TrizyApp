class GetCartItemsResponse {
  final bool success;
  final List<String> productIds;

  GetCartItemsResponse({
    required this.success,
    required this.productIds,
  });

  factory GetCartItemsResponse.fromJson(Map<String, dynamic> json) {
    return GetCartItemsResponse(
      success: json['success'],
      productIds: List<String>.from(json['productIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'productIds': productIds,
    };
  }
}