import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/subscription/cancel_subscription_response.dart';
import 'package:trizy_app/models/subscription/create_subscription_response.dart';
import 'package:trizy_app/models/subscription/get_subscription_status_response.dart';
import 'package:trizy_app/models/subscription/request/create_subscription_request.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class SubscriptionApiService {
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<CreateSubscriptionResponse> createSubscription({required CreateSubscriptionRequest request}) async {
    try {
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.createSubscription,
          addAuthToken: true,
          body: request.toJson()
      );
      print("response = ${response}");
      return CreateSubscriptionResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to create subscription: $e');
    }
  }


  Future<GetSubscriptionStatusResponse> getSubscriptionStatus() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getSubscriptionStatus,
          addAuthToken: true,
      );
      return GetSubscriptionStatusResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get subscription status: $e');
    }
  }


  Future<CancelSubscriptionResponse> cancelSubscription({required String subscriptionId}) async {
    try {
      final response = await _networkingManager.delete(
        endpoint: ApiEndpoints.cancelSubscription,
        addAuthToken: true,
        urlParams: {"subscriptionId":subscriptionId}
      );
      return CancelSubscriptionResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to cancel subscription: $e');
    }
  }



}