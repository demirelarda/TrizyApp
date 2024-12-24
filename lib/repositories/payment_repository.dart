import 'package:trizy_app/models/payment/create_payment_intent_response.dart';
import 'package:trizy_app/services/payment_api_service.dart';

class PaymentRepository {

  final PaymentApiService paymentApiService;

  PaymentRepository(this.paymentApiService);

  Future<CreatePaymentIntentResponse> createPaymentIntent() async {
    try {
      final CreatePaymentIntentResponse response = await paymentApiService.createPaymentIntent();
      return response;
    } catch (e) {
      throw Exception('Failed to create payment intent: $e');
    }
  }


}