import 'package:trizy_app/models/order/check_order_status_response.dart';
import 'package:trizy_app/models/order/get_user_orders_response.dart';
import 'package:trizy_app/services/orders_api_service.dart';

import '../di/locator.dart';
import '../services/local/local_product_service.dart';

class OrdersRepository {
  final OrdersApiService ordersApiService;
  final LocalProductService localProductService = getIt<LocalProductService>();
  OrdersRepository(this.ordersApiService);

  Future<CheckOrderStatusResponse> checkOrderStatus({required String paymentIntentId}) async {
    try {
      final CheckOrderStatusResponse response = await ordersApiService.checkOrderStatus(paymentIntentId: paymentIntentId);
      if(response.order != null){
        // order created, clear local cart
        localProductService.clearCart();
      }
      return response;
    } catch (e) {
      throw Exception('Failed to check order status: $e');
    }
  }


  Future<GetUserOrdersResponse> getUserOrders({required int page}) async {
    try {
      final GetUserOrdersResponse response = await ordersApiService.getUserOrders(page: page);
      return response;
    } catch (e) {
      throw Exception('Failed to get user ordersw: $e');
    }
  }



}