import 'package:trizy_app/models/review/create_review_request.dart';
import 'package:trizy_app/models/review/get_reviewable_products_response.dart';
import 'package:trizy_app/models/review/get_reviews_response.dart';
import 'package:trizy_app/models/review/review_operation_response.dart';
import 'package:trizy_app/services/review_api_service.dart';

class ReviewRepository {
  final ReviewApiService reviewApiService;

  ReviewRepository(this.reviewApiService);

  Future<ReviewOperationResponse> createReview({required CreateReviewRequest request}) async {
    try {
      final ReviewOperationResponse response = await reviewApiService.createReview(request: request);
      return response;
    } catch (e) {
      throw Exception('Failed to create review: $e');
    }
  }

  Future<ReviewOperationResponse> deleteReview({required String reviewId}) async {
    try {
      final ReviewOperationResponse response = await reviewApiService.deleteReview(reviewId: reviewId);
      return response;
    } catch (e) {
      throw Exception('Failed to delete review: $e');
    }
  }


  Future<GetReviewsResponse> getProductReviews({required String productId, required int page}) async {
    try {
      print("running get product reviews with product id = ${productId} and page ${page}");
      final GetReviewsResponse response = await reviewApiService.getProductReviews(productId: productId, page: page);
      return response;
    } catch (e) {
      throw Exception('Failed to get product reviews: $e');
    }
  }

  Future<GetReviewableProductsResponse> getReviewableProducts({required String orderId}) async {
    try {
      final GetReviewableProductsResponse response = await reviewApiService.getReviewableProducts(orderId: orderId);
      return response;
    } catch (e) {
      throw Exception('Failed to get reviewable products: $e');
    }
  }

}
