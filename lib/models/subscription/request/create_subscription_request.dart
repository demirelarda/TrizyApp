class CreateSubscriptionRequest {
  final String paymentMethodId;

  CreateSubscriptionRequest({
    required this.paymentMethodId,
  });

  Map<String, dynamic> toJson() {
    return {
      'paymentMethodId': paymentMethodId,
    };
  }
}