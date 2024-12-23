import 'address.dart';

class UpdateAddressResponse {
  final bool success;
  final String message;
  final Address? address;

  UpdateAddressResponse({
    required this.success,
    required this.message,
    this.address,
  });

  factory UpdateAddressResponse.fromJson(Map<String, dynamic> json) {
    return UpdateAddressResponse(
      success: json['success'],
      message: json['message'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'address': address?.toJson(),
    };
  }
}