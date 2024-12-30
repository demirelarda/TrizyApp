class ReviewOperationResponse {
  final bool success;
  final String message;

  ReviewOperationResponse({
    required this.success,
    required this.message,
  });

  factory ReviewOperationResponse.fromJson(Map<String, dynamic> json) {
    return ReviewOperationResponse(
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