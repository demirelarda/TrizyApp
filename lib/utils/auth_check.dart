import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isAuthenticated() async {
  final prefs = await SharedPreferences.getInstance();
  final accessToken = prefs.getString('accessToken');
  return accessToken != null && accessToken.isNotEmpty;
}