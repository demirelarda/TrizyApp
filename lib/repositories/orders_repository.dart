import 'package:trizy_app/models/order/check_order_status_response.dart';
import 'package:trizy_app/services/orders_api_service.dart';

class OrdersRepository {
  final OrdersApiService ordersApiService;
  OrdersRepository(this.ordersApiService);

  Future<CheckOrderStatusResponse> checkOrderStatus({required String paymentIntentId}) async {
    try {
      final CheckOrderStatusResponse response = await ordersApiService.checkOrderStatus(paymentIntentId: paymentIntentId);
      return response;
    } catch (e) {
      throw Exception('Failed to check order status: $e');
    }
  }


}