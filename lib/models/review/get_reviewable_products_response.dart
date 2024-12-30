class GetReviewableProductsResponse {
  final bool success;
  final List<ReviewableProduct> reviewableProducts;

  GetReviewableProductsResponse({
    required this.success,
    required this.reviewableProducts,
  });

  factory GetReviewableProductsResponse.fromJson(Map<String, dynamic> json) {
    return GetReviewableProductsResponse(
      success: json['success'],
      reviewableProducts: (json['reviewableProducts'] as List)
          .map((item) => ReviewableProduct.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'reviewableProducts':
      reviewableProducts.map((product) => product.toJson()).toList(),
    };
  }
}

class ReviewableProduct {
  final String id;
  final List<String> imageURLs;
  final String title;

  ReviewableProduct({
    required this.id,
    required this.imageURLs,
    required this.title,
  });

  factory ReviewableProduct.fromJson(Map<String, dynamic> json) {
    return ReviewableProduct(
      id: json['_id'],
      imageURLs: List<String>.from(json['imageURLs']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageURLs': imageURLs,
      'title': title,
    };
  }
}