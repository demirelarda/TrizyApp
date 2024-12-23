class Address {
  final String id;
  final String userId;
  final String fullName;
  final String phoneNumber;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final String addressType;
  final bool isDefault;
  final DateTime createdAt;

  Address({
    required this.id,
    required this.userId,
    required this.fullName,
    required this.phoneNumber,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    required this.addressType,
    required this.isDefault,
    required this.createdAt,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      id: json['_id'],
      userId: json['userId'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      address: json['address'],
      city: json['city'],
      state: json['state'],
      postalCode: json['postalCode'],
      country: json['country'],
      addressType: json['addressType'],
      isDefault: json['isDefault'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'address': address,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'country': country,
      'addressType': addressType,
      'isDefault': isDefault,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}