import 'package:trizy_app/models/category/categories_response.dart';
import 'package:trizy_app/services/categories_api_service.dart';

class CategoriesRepository {
  final CategoriesApiService categoriesApiService;

  CategoriesRepository(this.categoriesApiService);

  Future<CategoriesResponse> getRootCategories() async {
    try {
      final CategoriesResponse response = await categoriesApiService.getRootCategories();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<CategoriesResponse> getChildCategories(String rootCategoryId) async {
    try {
      final CategoriesResponse response = await categoriesApiService.getChildCategories(rootCategoryId);
      return response;
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

}