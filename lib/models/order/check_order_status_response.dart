import 'order.dart';

class CheckOrderStatusResponse {
  final bool success;
  final String message;
  final OrderData? order;

  CheckOrderStatusResponse({
    required this.success,
    required this.message,
    this.order,
  });

  factory CheckOrderStatusResponse.fromJson(Map<String, dynamic> json) {
    return CheckOrderStatusResponse(
      success: json['success'],
      message: json['message'],
      order: json['order'] != null ? OrderData.fromJson(json['order']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'order': order?.toJson(),
    };
  }
}