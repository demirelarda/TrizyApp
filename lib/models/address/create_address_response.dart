import 'package:trizy_app/models/address/address.dart';

class CreateAddressResponse {
  final bool success;
  final String message;
  final Address? address;

  CreateAddressResponse({
    required this.success,
    required this.message,
    this.address,
  });

  factory CreateAddressResponse.fromJson(Map<String, dynamic> json) {
    return CreateAddressResponse(
      success: json['success'],
      message: json['message'],
      address: json['address'] != null ? Address.fromJson(json['address']) : null,
    );
  }
}