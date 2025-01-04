import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/order/check_order_status_response.dart';
import 'package:trizy_app/models/order/get_user_orders_response.dart';
import 'package:trizy_app/models/order/order_details_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class OrdersApiService{
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();

  Future<CheckOrderStatusResponse> checkOrderStatus({required String paymentIntentId}) async {
    try {
      final response = await _networkingManager.get(
        endpoint: ApiEndpoints.checkOrderStatus,
        queryParams: {"paymentIntentId":paymentIntentId},
        addAuthToken: true
      );
      return CheckOrderStatusResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to check order status: $e');
    }
  }

  Future<GetUserOrdersResponse> getUserOrders({required int page}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getUserOrders,
          queryParams: {"page":page.toString()},
          addAuthToken: true
      );
      return GetUserOrdersResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to check order status: $e');
    }
  }

  Future<OrderDetailsResponse> getOrderDetails({required String orderId}) async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getOrderDetails,
          urlParams: {"orderId":orderId},
          addAuthToken: true
      );
      return OrderDetailsResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get order details: $e');
    }
  }


  Future<OrderDetailsResponse> getLatestOrderDetails() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getLatestOrderDetails,
          addAuthToken: true
      );
      return OrderDetailsResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get order details: $e');
    }
  }

}