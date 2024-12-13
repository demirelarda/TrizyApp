import 'package:trizy_app/models/deal/deals_response.dart';
import 'package:trizy_app/services/deals_api_service.dart';

class DealsRepository {
  final DealsApiService dealsApiService;

  DealsRepository(this.dealsApiService);

  Future<DealsResponse> getDeals() async {
    try {
      final DealsResponse response = await dealsApiService.getDeals();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch deals: $e');
    }
  }
}