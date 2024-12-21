class AddItemToCartOnFeedResponse {
  final bool success;
  final String message;

  AddItemToCartOnFeedResponse({
    required this.success,
    required this.message,
  });

  factory AddItemToCartOnFeedResponse.fromJson(Map<String, dynamic> json) {
    return AddItemToCartOnFeedResponse(
      success: json['success'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
    };
  }
}