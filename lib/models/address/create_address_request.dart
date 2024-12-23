class CreateAddressRequest {
  final String fullName;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String addressType;
  final bool isDefault;

  CreateAddressRequest({
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.addressType,
    this.isDefault = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'addressType': addressType,
      'isDefault': isDefault,
    };
  }
}