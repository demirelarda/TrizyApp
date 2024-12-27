import 'subscription.dart';

class GetSubscriptionStatusResponse {
  final bool success;
  final Subscription subscription;

  GetSubscriptionStatusResponse({
    required this.success,
    required this.subscription,
  });

  factory GetSubscriptionStatusResponse.fromJson(Map<String, dynamic> json) {
    return GetSubscriptionStatusResponse(
      success: json['success'] as bool,
      subscription:
      Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'subscription': subscription.toJson(),
    };
  }
}