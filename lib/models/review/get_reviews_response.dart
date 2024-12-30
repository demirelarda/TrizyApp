import 'package:trizy_app/models/review/review.dart';

class GetReviewsResponse {
  final bool success;
  final List<Review> reviews;
  final ReviewPagination pagination;
  final double averageRating;
  final int totalReviews;

  GetReviewsResponse({
    required this.success,
    required this.reviews,
    required this.pagination,
    required this.averageRating,
    required this.totalReviews,
  });

  factory GetReviewsResponse.fromJson(Map<String, dynamic> json) {
    return GetReviewsResponse(
      success: json['success'],
      reviews: (json['reviews'] as List)
          .map((review) => Review.fromJson(review))
          .toList(),
      pagination: ReviewPagination.fromJson(json['pagination']),
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: json['totalReviews'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'reviews': reviews.map((review) => review.toJson()).toList(),
      'pagination': pagination.toJson(),
      'averageRating': averageRating,
      'totalReviews': totalReviews,
    };
  }
}

class ReviewPagination {
  final int currentPage;
  final int totalPages;

  ReviewPagination({
    required this.currentPage,
    required this.totalPages,
  });

  factory ReviewPagination.fromJson(Map<String, dynamic> json) {
    return ReviewPagination(
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'totalPages': totalPages,
    };
  }
}