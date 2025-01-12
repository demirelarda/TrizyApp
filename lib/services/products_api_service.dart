import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/like/get_liked_products_response.dart';
import 'package:trizy_app/models/product/like_response.dart';
import 'package:trizy_app/models/product/products_response.dart';
import 'package:trizy_app/models/product/single_product_response.dart';
import 'package:trizy_app/models/trendingsearch/trending_search_response.dart';
import '../models/product/product_query_params.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class ProductsApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<ProductsResponse> getProductsByCategory({
    required String categoryId,
    required int page,
    ProductQueryParams? queryParameters,
  }) async {
    try {
      final params = {
        "page": page.toString(),
        ...?queryParameters?.toJson().map((key, value) => MapEntry(key, value.toString())),
      };

      final response = await _networkingManager.get(
        endpoint: ApiEndpoints.getProductsByCategory,
        urlParams: {"categoryId": categoryId},
        queryParams: params,
      );

      return ProductsResponse.fromJson(response);
    } catch (e) {
      print("Error : $e");
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<ProductsResponse> searchProducts({
    required String query,
    String? categoryId,
    required int page,
    ProductQueryParams? queryParameters,
  }) async {
    try {
      final params = {
        "query": query,
        "page": page.toString(),
        if (categoryId != null) "categoryId": categoryId,
        ...?queryParameters?.toJson().map((key, value) => MapEntry(key, value.toString())),
      };

      final response = await _networkingManager.get(
        endpoint: ApiEndpoints.searchProducts,
        queryParams: params,
        addAuthToken: true,
      );

      return ProductsResponse.fromJson(response);
    } catch (e) {
      print("Error : $e");
      throw Exception('Failed to fetch products: $e');
    }
  }

  Future<SingleProductResponse> getSingleProduct({required String productId}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getSingleProduct,
          urlParams: {"productId": productId},
          addAuthToken: true
      );
      return SingleProductResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch product: $e');
    }
  }


  Future<ProductsResponse> getLikedProducts({required int page}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getLikedProducts,
          queryParams: {"page": page.toString()},
          addAuthToken: true
      );
      return ProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch liked products: $e');
    }
  }


  Future<ProductsResponse> getBestOfProducts({required String period}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getBestOfProducts,
          queryParams: {"period": period},
          addAuthToken: true
      );
      return ProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch best of products: $e');
    }
  }


  Future<LikeResponse> likeProduct({required String productId}) async {
    try {
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.likeProduct,
          body: {"productId": productId},
          addAuthToken: true
      );
      return LikeResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to like product: $e');
    }
  }


  Future<LikeResponse> removeLike({required String productId}) async {
    try {
      final response = await _networkingManager.delete(
          endpoint: ApiEndpoints.removeLike,
          urlParams: {"productId": productId},
          addAuthToken: true
      );
      return LikeResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to unlike product: $e');
    }
  }


  Future<GetLikedProductsResponse> getLikedProductIds() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getLikedProductIds,
          addAuthToken: true
      );
      return GetLikedProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch liked products: $e');
    }
  }


  Future<TrendingSearchResponse> getTrendingSearches() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getTrendingSearches
      );
      return TrendingSearchResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch trending searches: $e');
    }
  }



}