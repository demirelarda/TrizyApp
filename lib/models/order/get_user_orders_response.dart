import 'order.dart';

class GetUserOrdersResponse {
  final bool success;
  final List<OrderData> orders;
  final int currentPage;
  final int totalPages;

  GetUserOrdersResponse({
    required this.success,
    required this.orders,
    required this.currentPage,
    required this.totalPages,
  });

  factory GetUserOrdersResponse.fromJson(Map<String, dynamic> json) {
    return GetUserOrdersResponse(
      success: json['success'],
      orders: (json['orders'] as List)
          .map((order) => OrderData.fromJson(order))
          .toList(),
      currentPage: json['currentPage'],
      totalPages: json['totalPages'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'orders': orders.map((order) => order.toJson()).toList(),
      'currentPage': currentPage,
      'totalPages': totalPages,
    };
  }
}