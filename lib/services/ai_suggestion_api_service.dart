import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/product/products_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class AiSuggestionApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<ProductsResponse> getAiSuggestions() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getAiSuggestions,
          addAuthToken: true
      );
      return ProductsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch AI suggestions: $e');
    }
  }

}