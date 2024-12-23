class DeleteAddressResponse {
  final bool success;
  final String message;

  DeleteAddressResponse({
    required this.success,
    required this.message,
  });

  factory DeleteAddressResponse.fromJson(Map<String, dynamic> json) {
    return DeleteAddressResponse(
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