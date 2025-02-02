class SignUpResponse {
  final String userFirstName;
  final String userLastName;
  final String email;
  final bool emailVerified;
  final String id;
  final String refreshToken;
  final String accessToken;

  SignUpResponse({
    required this.userFirstName,
    required this.userLastName,
    required this.email,
    required this.emailVerified,
    required this.id,
    required this.refreshToken,
    required this.accessToken,
  });

  factory SignUpResponse.fromJson(Map<String, dynamic> json) {
    return SignUpResponse(
      userFirstName: json['userFirstName'],
      userLastName: json['userLastName'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      id: json['_id'],
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
    );
  }
}