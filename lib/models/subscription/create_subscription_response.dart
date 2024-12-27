import 'subscription.dart';

class CreateSubscriptionResponse {
  final bool success;
  final Subscription subscription;
  final String subscriptionStatus;
  final String? clientSecret;
  final String message;

  CreateSubscriptionResponse({
    required this.success,
    required this.subscription,
    required this.subscriptionStatus,
    this.clientSecret,
    required this.message,
  });

  factory CreateSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return CreateSubscriptionResponse(
      success: json['success'] as bool,
      subscription:
      Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
      subscriptionStatus: json['subscriptionStatus'] as String,
      clientSecret: json['clientSecret'] as String?,
      message: json['message'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'subscription': subscription.toJson(),
      'subscriptionStatus': subscriptionStatus,
      'clientSecret': clientSecret,
      'message': message,
    };
  }
}