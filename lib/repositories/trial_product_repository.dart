import 'package:trizy_app/services/trial_product_api_service.dart';
import '../models/trialproduct/single_trial_product_response.dart';
import '../models/trialproduct/trial_products_response.dart';

class TrialProductsRepository {
  final TrialProductApiService trialProductApiService;

  TrialProductsRepository(this.trialProductApiService);


  Future<TrialProductsResponse> getLatestTrialProducts({required int page}) async {
    try {
      final TrialProductsResponse response = await trialProductApiService.getLatestTrialProducts(page: page);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch trial products: $e');
    }
  }

  Future<TrialProductsResponse> getTrialProductsByCategory({required String categoryId, required int page}) async {
    try {
      final TrialProductsResponse response = await trialProductApiService.getTrialProductsByCategory(categoryId: categoryId, page: page);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch trial products: $e');
    }
  }

  Future<TrialProductsResponse> searchTrialProducts({required String query, String? categoryId, required int page}) async {
    try {
      final TrialProductsResponse response = await trialProductApiService.searchTrialProducts(query: query, page: page, categoryId: categoryId);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch trial products: $e');
    }
  }

  Future<SingleTrialProductResponse> getSingleTrialProduct({required String productId}) async {
    try {
      final SingleTrialProductResponse response = await trialProductApiService.getSingleTrialProduct(productId: productId);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch trial products: $e');
    }
  }

}