import 'package:get_it/get_it.dart';
import '../models/deal/deals_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class DealsApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<DealsResponse> getDeals() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getDeals
      );
      return DealsResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to fetch deals: $e');
    }
  }
}