import 'dart:convert';

class ProductQueryParams {
  final String? query;
  final String? categoryId;
  final double? minPrice;
  final double? maxPrice;
  final List<int>? exactRatings;
  final int? minRatingCount;
  final int? maxRatingCount;
  final int? minLikeCount;
  final int? maxLikeCount;
  final String? sortBy;

  ProductQueryParams({
    this.query,
    this.categoryId,
    this.minPrice,
    this.maxPrice,
    this.exactRatings,
    this.minRatingCount,
    this.maxRatingCount,
    this.minLikeCount,
    this.maxLikeCount,
    this.sortBy,
  });

  Map<String, dynamic> toJson() {
    return {
      "query": query,
      "categoryId": categoryId,
      "minPrice": minPrice?.toString(),
      "maxPrice": maxPrice?.toString(),
      "exactRatings": exactRatings?.join(","),
      "minRatingCount": minRatingCount?.toString(),
      "maxRatingCount": maxRatingCount?.toString(),
      "minLikeCount": minLikeCount?.toString(),
      "maxLikeCount": maxLikeCount?.toString(),
      "sortBy": sortBy,
    }..removeWhere((key, value) => value == null);
  }

  String toJsonString() {
    return jsonEncode(toJson());
  }

  ProductQueryParams copyWith({
    String? query,
    String? categoryId,
    double? minPrice,
    double? maxPrice,
    List<int>? exactRatings,
    int? minRatingCount,
    int? maxRatingCount,
    int? minLikeCount,
    int? maxLikeCount,
    String? sortBy,
  }) {
    return ProductQueryParams(
      query: query ?? this.query,
      categoryId: categoryId ?? this.categoryId,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      exactRatings: exactRatings ?? this.exactRatings,
      minRatingCount: minRatingCount ?? this.minRatingCount,
      maxRatingCount: maxRatingCount ?? this.maxRatingCount,
      minLikeCount: minLikeCount ?? this.minLikeCount,
      maxLikeCount: maxLikeCount ?? this.maxLikeCount,
      sortBy: sortBy ?? this.sortBy,
    );
  }
}