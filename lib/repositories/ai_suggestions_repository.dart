import 'package:trizy_app/models/product/products_response.dart';
import 'package:trizy_app/services/ai_suggestion_api_service.dart';

class AiSuggestionsRepository {

  final AiSuggestionApiService aiSuggestionApiService;

  AiSuggestionsRepository(this.aiSuggestionApiService);


  Future<ProductsResponse> getAiSuggestions() async {
    try {
      final ProductsResponse response = await aiSuggestionApiService.getAiSuggestions();
      return response;
    } catch (e) {
      throw Exception('Failed to get ai suggestions: $e');
    }
  }


}