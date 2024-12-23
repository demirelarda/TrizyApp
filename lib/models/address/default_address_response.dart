import 'address.dart';

class DefaultAddressResponse {
  final bool success;
  final Address? address;
  final String? message;

  DefaultAddressResponse({
    required this.success,
    this.address,
    this.message,
  });

  factory DefaultAddressResponse.fromJson(Map<String, dynamic> json) {
    return DefaultAddressResponse(
      success: json['success'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'address': address?.toJson(),
      'message': message,
    };
  }
}