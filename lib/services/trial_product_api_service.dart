import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/trialproduct/single_trial_product_response.dart';
import 'package:trizy_app/models/trialproduct/trial_products_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class TrialProductApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<TrialProductsResponse> getLatestTrialProducts({required int page}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getLatestTrialProducts,
          queryParams: {"page": page.toString()}
      );
      return TrialProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch trial products: $e');
    }
  }


  Future<TrialProductsResponse> getTrialProductsByCategory({required String categoryId, required int page}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getTrialProductsByCategory,
          urlParams: {"categoryId": categoryId},
          queryParams: {"page": page.toString()}
      );
      return TrialProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch trial products: $e');
    }
  }


  Future<TrialProductsResponse> searchTrialProducts({required String query, String? categoryId, required int page}) async {
    try {
      late Map<String, dynamic> response;
      if(categoryId != null){
        // search with category filter
        response = await _networkingManager.get(
          endpoint: ApiEndpoints.searchTrialProducts,
          queryParams: {"query": query, "categoryId": categoryId, "page": page.toString()},
        );
      }
      else{
        // search only with query
        response = await _networkingManager.get(
            endpoint: ApiEndpoints.searchTrialProducts,
            queryParams: {"query": query, "page": page.toString()}
        );
      }
      return TrialProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch trial products: $e');
    }
  }

  Future<SingleTrialProductResponse> getSingleTrialProduct({required String productId}) async {
    try {
      final response = await _networkingManager.get(
        endpoint: ApiEndpoints.getSingleTrialProduct,
        urlParams: {"trialProductId": productId},
      );
      return SingleTrialProductResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch product: $e');
    }
  }



}