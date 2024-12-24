class CreatePaymentIntentResponse {
  final bool success;
  final PaymentIntentData paymentIntent;

  CreatePaymentIntentResponse({
    required this.success,
    required this.paymentIntent,
  });

  factory CreatePaymentIntentResponse.fromJson(Map<String, dynamic> json) {
    return CreatePaymentIntentResponse(
      success: json['success'],
      paymentIntent: PaymentIntentData.fromJson(json['paymentIntent']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'paymentIntent': paymentIntent.toJson(),
    };
  }
}

class PaymentIntentData {
  final String id;
  final String clientSecret;

  PaymentIntentData({
    required this.id,
    required this.clientSecret,
  });

  factory PaymentIntentData.fromJson(Map<String, dynamic> json) {
    return PaymentIntentData(
      id: json['id'],
      clientSecret: json['clientSecret'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientSecret': clientSecret,
    };
  }
}