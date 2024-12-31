class AiSuggestedProductsResponse {
  final bool success;
  final List<SuggestedProduct> suggestions;

  AiSuggestedProductsResponse({
    required this.success,
    required this.suggestions,
  });

  factory AiSuggestedProductsResponse.fromJson(Map<String, dynamic> json) {
    return AiSuggestedProductsResponse(
      success: json['success'],
      suggestions: (json['suggestions'] as List<dynamic>)
          .map((item) => SuggestedProduct.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'suggestions': suggestions.map((item) => item.toJson()).toList(),
    };
  }
}

class SuggestedProduct {
  final String id;
  final List<String> imageURLs;
  final String title;
  final String description;
  final double price;
  final int stockCount;
  final String category;
  final List<String> tags;
  final double cargoWeight;
  final double? averageRating;
  final int? likeCount;
  final int? reviewCount;
  final String reason;

  SuggestedProduct({
    required this.id,
    required this.imageURLs,
    required this.title,
    required this.description,
    required this.price,
    required this.stockCount,
    required this.category,
    required this.tags,
    required this.cargoWeight,
    this.averageRating,
    this.likeCount,
    this.reviewCount,
    required this.reason,
  });

  factory SuggestedProduct.fromJson(Map<String, dynamic> json) {
    return SuggestedProduct(
      id: json['_id'],
      imageURLs: List<String>.from(json['imageURLs']),
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      stockCount: json['stockCount'],
      category: json['category'],
      tags: List<String>.from(json['tags']),
      cargoWeight: (json['cargoWeight'] as num).toDouble(),
      averageRating: json['averageRating'] != null
          ? (json['averageRating'] as num).toDouble()
          : null,
      likeCount: json['likeCount'] != null ? json['likeCount'] as int : null,
      reviewCount: json['reviewCount'] != null ? json['reviewCount'] as int : null,
      reason: json['reason'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'imageURLs': imageURLs,
      'title': title,
      'description': description,
      'price': price,
      'stockCount': stockCount,
      'category': category,
      'tags': tags,
      'cargoWeight': cargoWeight,
      'averageRating': averageRating,
      'likeCount': likeCount,
      'reviewCount': reviewCount,
      'reason': reason,
    };
  }
}