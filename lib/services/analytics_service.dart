/*
import 'package:firebase_analytics/firebase_analytics.dart';
import '../utils/auth_check.dart';

class AnalyticsService {
  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  Future<void> logEvent(String eventName, {Map<String, dynamic>? parameters}) async {
    try {
      if (!await isAuthenticated()) {
        print("User is not authenticated. Skipping analytics.");
        return;
      }

      final user = await getUser();
      if (user == null) {
        print("Failed to fetch user data. Skipping analytics.");
        return;
      }

      final Map<String, dynamic> enrichedParameters = {
        'user_id': user.id,
        'is_subscriber': user.isSubscriber ? 1 : 0,
        'has_active_trial': user.hasActiveTrial ? 1 : 0,
        ...?parameters,
      };


      final Map<String, Object> castedParameters = enrichedParameters.map((key, value) => MapEntry(key, value as Object));

      await _analytics.logEvent(
        name: eventName,
        parameters: castedParameters,
      );

      print("Event logged: $eventName, parameters: $castedParameters");
    } catch (e) {
      print("Error logging event: $e");
    }
  }

  Future<void> logProductView(String productId) async {
    await logEvent('product_viewed', parameters: {
      'product_id': productId
    });
  }

  Future<void> logSearch(String searchTerm) async {
    await logEvent('search_performed', parameters: {
      'search_term': searchTerm,
    });
  }

  Future<void> logPurchase(String orderId, double amount) async {
    await logEvent('purchase_made', parameters: {
      'order_id': orderId,
      'amount': amount,
    });
  }
}

 */