import 'address.dart';

class GetAddressResponse {
  final bool success;
  final List<Address> addresses;

  GetAddressResponse({
    required this.success,
    required this.addresses,
  });

  factory GetAddressResponse.fromJson(Map<String, dynamic> json) {
    return GetAddressResponse(
      success: json['success'],
      addresses: (json['addresses'] as List)
          .map((address) => Address.fromJson(address))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'addresses': addresses.map((address) => address.toJson()).toList(),
    };
  }
}