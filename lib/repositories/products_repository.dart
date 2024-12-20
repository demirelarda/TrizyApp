import 'package:trizy_app/models/product/products_response.dart';
import 'package:trizy_app/models/product/single_product_response.dart';
import 'package:trizy_app/services/products_api_service.dart';

class ProductsRepository {
  final ProductsApiService productsApiService;

  ProductsRepository(this.productsApiService);

  Future<ProductsResponse> getProductsByCategory({required String categoryId, required int page}) async {
    try {
      final ProductsResponse response = await productsApiService.getProductsByCategory(categoryId: categoryId, page: page);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch deals: $e');
    }
  }

  Future<ProductsResponse> searchProducts({required String query, String? categoryId, required int page}) async {
    try {
      final ProductsResponse response = await productsApiService.searchProducts(query: query, page: page, categoryId: categoryId);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch deals: $e');
    }
  }

  Future<SingleProductResponse> getSingleProduct({required String productId}) async {
    try {
      final SingleProductResponse response = await productsApiService.getSingleProduct(productId: productId);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch deals: $e');
    }
  }

}