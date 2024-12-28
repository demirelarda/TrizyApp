import 'package:shared_preferences/shared_preferences.dart';

Future<bool> isSubscribed() async {
  final prefs = await SharedPreferences.getInstance();
  final isSubscriber = prefs.getBool('isSubscriber');
  return isSubscriber ?? false;
}


Future<void> updateSubscriptionStatus(bool isSubscribed) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isSubscriber', isSubscribed);
}