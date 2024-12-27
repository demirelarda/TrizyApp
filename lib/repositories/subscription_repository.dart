import 'package:trizy_app/models/subscription/cancel_subscription_response.dart';
import 'package:trizy_app/models/subscription/create_subscription_response.dart';
import 'package:trizy_app/models/subscription/get_subscription_status_response.dart';
import 'package:trizy_app/models/subscription/request/create_subscription_request.dart';
import '../services/subscription_api_service.dart';

class SubscriptionRepository {
  final SubscriptionApiService subscriptionApiService;

  SubscriptionRepository(this.subscriptionApiService);

  Future<CreateSubscriptionResponse> createSubscription({required CreateSubscriptionRequest request}) async {
    try {
      final CreateSubscriptionResponse response = await subscriptionApiService.createSubscription(request: request);
      return response;
    } catch (e) {
      throw Exception('Failed to create subscription: $e');
    }
  }

  Future<GetSubscriptionStatusResponse> getSubscriptionStatus() async {
    try {
      final GetSubscriptionStatusResponse response = await subscriptionApiService.getSubscriptionStatus();
      return response;
    } catch (e) {
      throw Exception('Failed to get subscription status: $e');
    }
  }


  Future<CancelSubscriptionResponse> cancelSubscription({required String subscriptionId}) async {
    try {
      final CancelSubscriptionResponse response = await subscriptionApiService.cancelSubscription(subscriptionId: subscriptionId);
      return response;
    } catch (e) {
      throw Exception('Failed to cancel subscription: $e');
    }
  }


}