import 'package:get_it/get_it.dart';
import 'package:trizy_app/models/cart/request/add_item_to_cart_request.dart';
import 'package:trizy_app/models/cart/response/add_item_to_cart_response.dart';
import 'package:trizy_app/models/cart/response/decrement_quantity_response.dart';
import 'package:trizy_app/models/cart/response/delete_item_from_cart_response.dart';
import 'package:trizy_app/models/cart/response/get_cart_response.dart';
import '../utils/api_endpoints.dart';
import '../utils/networking_manager.dart';

class CartApiService{
  final NetworkingManager _networkingManager = GetIt.instance<NetworkingManager>();


  Future<GetCartResponse> getUserCart() async {
    try {
      final response = await _networkingManager.get(
          endpoint: ApiEndpoints.getUserCart,
          addAuthToken: true
      );
      return GetCartResponse.fromJson(response);
    } catch (e) {
      print("error : ${e}");
      throw Exception('Failed to get user cart: $e');
    }
  }


  Future<AddItemToCartResponse> addItemToCart({required AddItemToCartRequest request}) async {
    try {
      final response = await _networkingManager.post(
          endpoint: ApiEndpoints.addItemToCart,
          addAuthToken: true,
          body: request.toJson()
      );
      return AddItemToCartResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to add item to cart: $e');
    }
  }


  Future<DeleteItemFromCartResponse> deleteItemFromCart({required productId}) async {
    try {
      final response = await _networkingManager.delete(
          endpoint: ApiEndpoints.deleteItemFromCart,
          addAuthToken: true,
          urlParams: {"productId":productId}

      );
      return DeleteItemFromCartResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to add item to cart: $e');
    }
  }


  Future<DecrementQuantityResponse> decrementItemQuantity({required productId}) async {
    try {
      final response = await _networkingManager.patch(
          endpoint: ApiEndpoints.decrementQuantity,
          addAuthToken: true,
          body: {"productId":productId}
      );
      return DecrementQuantityResponse.fromJson(response);
    }
    catch (e) {
      print("error : ${e}");
      throw Exception('Failed to add item to cart: $e');
    }
  }


}