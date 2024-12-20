import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/product/products_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class ProductsApiService {
  final NetworkingManager _networkingManager = GetIt.instance<
      NetworkingManager>();

  Future<ProductsResponse> getProductsByCategory({required String categoryId, required int page}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getProductsByCategory,
          urlParams: {"categoryId": categoryId},
          queryParams: {"page": page.toString()}
      );
      return ProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch products: $e');
    }
  }


  Future<ProductsResponse> searchProducts({required String query, String? categoryId, required int page}) async {
    try {
      late Map<String, dynamic> response;
      if(categoryId != null){
        // search with category filter
        response = await _networkingManager.get(
            endpoint: ApiEndpoints.searchProducts,
            queryParams: {"query": query, "categoryId": categoryId, "page": page.toString()},
        );
      }
      else{
        // search only with query
        response = await _networkingManager.get(
            endpoint: ApiEndpoints.searchProducts,
            queryParams: {"query": query, "page": page.toString()}
        );
      }
      return ProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch products: $e');
    }
  }


}