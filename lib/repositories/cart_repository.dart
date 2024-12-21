import 'package:trizy_app/models/cart/request/add_item_to_cart_request.dart';
import 'package:trizy_app/models/cart/response/add_item_to_cart_on_feed_response.dart';
import 'package:trizy_app/models/cart/response/cart_operation_response.dart';
import 'package:trizy_app/models/cart/response/get_cart_response.dart';
import 'package:trizy_app/services/cart_api_service.dart';

class CartRepository {
  final CartApiService cartApiService;

  CartRepository(this.cartApiService);

  Future<GetCartResponse> getUserCart() async {
    try {
      final GetCartResponse response = await cartApiService.getUserCart();
      return response;
    } catch (e) {
      throw Exception('Failed to fetch cart: $e');
    }
  }


  Future<CartOperationResponse> addItemToCart({required AddItemToCartRequest request}) async {
    try {
      final CartOperationResponse response = await cartApiService.addItemToCart(request: request);
      return response;
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }


  Future<CartOperationResponse> deleteItemFromCart({required String productId}) async {
    try {
      final CartOperationResponse response = await cartApiService.deleteItemFromCart(productId: productId);
      return response;
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }


  Future<CartOperationResponse> decrementItemQuantity({required String productId}) async {
    try {
      final CartOperationResponse response = await cartApiService.decrementItemQuantity(productId: productId);
      return response;
    } catch (e) {
      throw Exception('Failed to decrement item quantity: $e');
    }
  }

  Future<AddItemToCartOnFeedResponse> addItemOnFeed({required String productId}) async {
    try {
      final AddItemToCartOnFeedResponse response = await cartApiService.addItemOnFeed(productId: productId);
      return response;
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }

}