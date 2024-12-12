import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/auth/request/sign_in_request.dart';
import '../models/auth/request/sign_up_request.dart';
import '../models/auth/response/sign_in_response.dart';
import '../models/auth/response/sign_up_response.dart';
import '../models/user/user_model.dart';
import '../models/user/user_pref_model.dart';
import '../services/auth_api_service.dart';

class AuthRepository {
  final AuthApiService apiService;

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
      ));

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