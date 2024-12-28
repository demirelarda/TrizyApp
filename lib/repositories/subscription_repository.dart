import 'package:trizy_app/models/subscription/cancel_subscription_response.dart';
import 'package:trizy_app/models/subscription/create_subscription_response.dart';
import 'package:trizy_app/models/subscription/get_subscription_status_response.dart';
import 'package:trizy_app/models/subscription/request/create_subscription_request.dart';
import 'package:trizy_app/utils/sub_check.dart';
import '../services/subscription_api_service.dart';

class SubscriptionRepository {
  final SubscriptionApiService subscriptionApiService;

  SubscriptionRepository(this.subscriptionApiService);

  Future<CreateSubscriptionResponse> createSubscription({required CreateSubscriptionRequest request}) async {
    try {
      final CreateSubscriptionResponse response = await subscriptionApiService.createSubscription(request: request);
      if(response.success && response.subscription.isActive == true){
        updateSubscriptionStatus(true);
      }
      return response;
    } catch (e) {
      throw Exception('Failed to create subscription: $e');
    }
  }

  Future<GetSubscriptionStatusResponse> getSubscriptionStatus() async {
    try {
      final GetSubscriptionStatusResponse response = await subscriptionApiService.getSubscriptionStatus();
      if(response.success && response.subscription.isActive == true){
        updateSubscriptionStatus(true);
      }
      return response;
    } catch (e) {
      throw Exception('Failed to get subscription status: $e');
    }
  }


  Future<CancelSubscriptionResponse> cancelSubscription({required String subscriptionId}) async {
    try {
      final CancelSubscriptionResponse response = await subscriptionApiService.cancelSubscription(subscriptionId: subscriptionId);
      if(response.success && response.subscription.isActive == false){
        updateSubscriptionStatus(false);
      }
      return response;
    } catch (e) {
      throw Exception('Failed to cancel subscription: $e');
    }
  }


}