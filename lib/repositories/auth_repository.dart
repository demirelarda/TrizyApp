import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trizy_app/models/local/local_liked_product.dart';
import 'package:trizy_app/services/local/local_product_service.dart';
import '../di/locator.dart';
import '../models/auth/request/sign_in_request.dart';
import '../models/auth/request/sign_up_request.dart';
import '../models/auth/response/sign_in_response.dart';
import '../models/auth/response/sign_up_response.dart';
import '../models/local/local_cart_item.dart';
import '../models/user/user_model.dart';
import '../models/user/user_pref_model.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService apiService;
  final LocalProductService localProductService = getIt<LocalProductService>();

  AuthRepository(this.apiService);

  Future<User> signUp(SignUpRequest request) async {
    try {
      final SignUpResponse response = await apiService.register(request);

      final user = User(
        id: response.id,
        email: response.email,
        firstName: response.userFirstName,
        lastName: response.userLastName,
        emailVerified: response.emailVerified,
      );

      await _saveTokens(response.accessToken, response.refreshToken);

      await _saveUser(UserPreferencesModel(
        id: response.id,
        email: response.email,
        firstName: response.userFirstName,
        lastName: response.userLastName,
      ));

      return user;
    } catch (e) {
      throw Exception('Failed to sign up: $e');
    }
  }

  Future<User> signIn(SignInRequest request) async {
    try {
      final SignInResponse response = await apiService.signIn(request);

      final user = User(
        id: response.id,
        email: response.email,
        firstName: response.userFirstName,
        lastName: response.userLastName,
        emailVerified: response.emailVerified,
      );

      await _saveTokens(response.accessToken, response.refreshToken);

      await _saveUser(UserPreferencesModel(
        id: response.id,
        email: response.email,
        firstName: response.userFirstName,
        lastName: response.userLastName,
        isSubscriber: response.isSubscriber
      ));

      final List<String> severLikedProductIds = response.likedProductIds;
      final List<String> serverCartItemIds = response.cartItemIds;

      final List<LocalCartItem> localCartItems = serverCartItemIds.map((id) {
        return LocalCartItem(productId: id);
      }).toList();

      final List<LocalLikedProduct> localLikedProducts = severLikedProductIds.map((id) {
        return LocalLikedProduct(productId: id, likedAt: DateTime.now());
      }).toList();

      if(severLikedProductIds.isNotEmpty){
       await localProductService.clearLikesAndInsertAllLikes(localLikedProducts);
      }
      else{
        await localProductService.clearAllLikes();
      }

      if(serverCartItemIds.isNotEmpty){
        await localProductService.clearCartAndInsertAllCartItems(localCartItems);
      }
      else{
        await localProductService.clearCart();
      }

      return user;
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }


  Future<void> _saveTokens(String accessToken, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', accessToken);
    await prefs.setString('refreshToken', refreshToken);
  }

  Future<void> _saveUser(UserPreferencesModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userJson = jsonEncode(user.toJson());
    await prefs.setString('user', userJson);
  }

  Future<UserPreferencesModel?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');
    if (userJson == null) return null;
    Map<String, dynamic> userMap = jsonDecode(userJson);
    return UserPreferencesModel.fromJson(userMap);
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('accessToken');
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refreshToken');
  }

  Future<void> clearAllData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');
  }
}