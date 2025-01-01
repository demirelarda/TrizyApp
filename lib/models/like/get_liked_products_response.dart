class GetLikedProductsResponse {
  final bool success;
  final List<String> likedProductIds;

  GetLikedProductsResponse({
    required this.success,
    required this.likedProductIds,
  });

  factory GetLikedProductsResponse.fromJson(Map<String, dynamic> json) {
    return GetLikedProductsResponse(
      success: json['success'],
      likedProductIds: List<String>.from(json['likedProductIds']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'likedProductIds': likedProductIds,
    };
  }
}