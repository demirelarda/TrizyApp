import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/payment/create_payment_intent_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class PaymentApiService{
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<CreatePaymentIntentResponse> createPaymentIntent() async {
    try {
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.createPaymentIntent,
          addAuthToken: true,
          body: {},
      );
      return CreatePaymentIntentResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to create payment intent: $e');
    }
  }


}