import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/review/create_review_request.dart';
import 'package:trizy_app/models/review/get_reviewable_products_response.dart';
import 'package:trizy_app/models/review/review_operation_response.dart';
import '../models/review/get_reviews_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class ReviewApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<ReviewOperationResponse> createReview({required CreateReviewRequest request}) async {
    try {
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.createReview,
          body: request.toJson(),
          addAuthToken: true
      );
      return ReviewOperationResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to create review: $e');
    }
  }

  Future<ReviewOperationResponse> deleteReview({required String reviewId}) async {
    try {
      final response = await _networkingManager.delete(
          endpoint: ApiEndpoints.deleteReview,
          urlParams: {"reviewId":reviewId},
          addAuthToken: true
      );
      return ReviewOperationResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to delete review: $e');
    }
  }

  Future<GetReviewsResponse> getProductReviews({required String productId, required int page}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getProductReviews,
          urlParams: {"productId":productId},
          queryParams: {"page":page.toString()}
      );
      print("response = ${response}");
      return GetReviewsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get product reviews: $e');
    }
  }


  Future<GetReviewableProductsResponse> getReviewableProducts({required String orderId}) async {
    try {
      final response = await _networkingManager.get(
        endpoint: ApiEndpoints.getReviewableProducts,
        urlParams: {"orderId":orderId},
        addAuthToken: true
      );
      return GetReviewableProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get reviewable products: $e');
    }
  }


}