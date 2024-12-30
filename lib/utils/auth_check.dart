import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user/user_pref_model.dart';

Future<bool> isAuthenticated() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  return accessToken != null && accessToken.isNotEmpty;
}

Future<UserPreferencesModel?> getUser() async {
  final prefs = await SharedPreferences.getInstance();
  String? userJson = prefs.getString('user');
  if (userJson == null) return null;
  Map<String, dynamic> userMap = jsonDecode(userJson);
  return UserPreferencesModel.fromJson(userMap);
}