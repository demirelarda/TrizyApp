import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/category/categories_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class CategoriesApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<CategoriesResponse> getRootCategories() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getRootCategories
      );
      return CategoriesResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch categories: $e');
    }
  }


  Future<CategoriesResponse> getChildCategories(String rootCategoryId) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getChildCategories,
          urlParams: {"rootCategoryId":rootCategoryId}
      );
      return CategoriesResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch categories: $e');
    }
  }




}