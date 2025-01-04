class UserProfileResponse {
  final bool success;
  final UserProfileData data;

  UserProfileResponse({
    required this.success,
    required this.data,
  });

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) {
    return UserProfileResponse(
      success: json['success'],
      data: UserProfileData.fromJson(json['data']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'data': data.toJson(),
    };
  }
}

class UserProfileData {
  final String userFirstName;
  final String userLastName;
  final String email;
  final bool hasActiveSubscription;

  UserProfileData({
    required this.userFirstName,
    required this.userLastName,
    required this.email,
    required this.hasActiveSubscription,
  });

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      userFirstName: json['userFirstName'],
      userLastName: json['userLastName'],
      email: json['email'],
      hasActiveSubscription: json['hasActiveSubscription'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'email': email,
      'hasActiveSubscription': hasActiveSubscription,
    };
  }
}