import 'subscription.dart';

class CancelSubscriptionResponse {
  final bool success;
  final String message;
  final Subscription subscription;

  CancelSubscriptionResponse({
    required this.success,
    required this.message,
    required this.subscription,
  });

  factory CancelSubscriptionResponse.fromJson(Map<String, dynamic> json) {
    return CancelSubscriptionResponse(
      success: json['success'] as bool,
      message: json['message'] as String,
      subscription:
      Subscription.fromJson(json['subscription'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'subscription': subscription.toJson(),
    };
  }
}