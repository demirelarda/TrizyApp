import 'package:trizy_app/models/cart/request/add_item_to_cart_request.dart';
import 'package:trizy_app/models/cart/response/add_item_to_cart_on_feed_response.dart';
import 'package:trizy_app/models/cart/response/cart_operation_response.dart';
import 'package:trizy_app/models/cart/response/get_cart_items_response.dart';
import 'package:trizy_app/models/cart/response/get_cart_response.dart';
import 'package:trizy_app/services/cart_api_service.dart';
import '../di/locator.dart';
import '../models/cart/cart.dart';
import '../models/local/local_cart_item.dart';
import '../services/local/local_product_service.dart';

class CartRepository {
  final CartApiService cartApiService;
  final LocalProductService localProductService = getIt<LocalProductService>();

  CartRepository(this.cartApiService);

  Future<GetCartResponse> getUserCart() async {
    try {
      final GetCartResponse response = await cartApiService.getUserCart();
      final List<CartItem> serverCartItems = response.cart.items;

      final List<LocalCartItem> localCartItems = serverCartItems.map((item) {
        return LocalCartItem(productId: item.productId);
      }).toList();

      await localProductService.clearCartAndInsertAllCartItems(localCartItems);

      return response;
    } catch (e) {
      throw Exception('Failed to fetch cart: $e');
    }
  }


  Future<CartOperationResponse> addItemToCart({required AddItemToCartRequest request}) async {
    try {
      final CartOperationResponse response = await cartApiService.addItemToCart(request: request);
      final List<CartItem> serverCartItems = response.cart.items;

      final List<LocalCartItem> localCartItems = serverCartItems.map((item) {
        return LocalCartItem(productId: item.productId);
      }).toList();

      await localProductService.clearCartAndInsertAllCartItems(localCartItems);
      return response;
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }


  Future<CartOperationResponse> deleteItemFromCart({required String productId}) async {
    try {
      final CartOperationResponse response = await cartApiService.deleteItemFromCart(productId: productId);
      localProductService.removeFromCart(productId);
      final List<CartItem> serverCartItems = response.cart.items;

      final List<LocalCartItem> localCartItems = serverCartItems.map((item) {
        return LocalCartItem(productId: item.productId);
      }).toList();

      await localProductService.clearCartAndInsertAllCartItems(localCartItems);
      return response;
    } catch (e) {
      throw Exception('Failed to delete item: $e');
    }
  }


  Future<CartOperationResponse> decrementItemQuantity({required String productId}) async {
    try {
      final CartOperationResponse response = await cartApiService.decrementItemQuantity(productId: productId);
      final List<CartItem> serverCartItems = response.cart.items;
      final List<LocalCartItem> localCartItems = serverCartItems.map((item) {
        return LocalCartItem(productId: item.productId);
      }).toList();
      await localProductService.clearCartAndInsertAllCartItems(localCartItems);
      return response;
    } catch (e) {
      throw Exception('Failed to decrement item quantity: $e');
    }
  }

  Future<AddItemToCartOnFeedResponse> addItemOnFeed({required String productId}) async {
    try {
      final AddItemToCartOnFeedResponse response = await cartApiService.addItemOnFeed(productId: productId);
      await localProductService.addToCart(productId);
      return response;
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }


  Future<GetCartItemsResponse> getCartItemsAndSaveToLocal() async {
    try {
      final GetCartItemsResponse response = await cartApiService.getCartItemIds();

      final List<String> serverCartItemIds = response.productIds;
      final List<LocalCartItem> localCartItems = serverCartItemIds.map((id) {
        return LocalCartItem(productId: id);
      }).toList();

      if(serverCartItemIds.isNotEmpty){
        await localProductService.clearCartAndInsertAllCartItems(localCartItems);
      }
      else{
        await localProductService.clearCart();
      }

      return response;
    } catch (e) {
      throw Exception('Failed to add item: $e');
    }
  }




}