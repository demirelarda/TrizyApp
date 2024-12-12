class SignUpRequest {
  final String email;
  final String userFirstName;
  final String userLastName;
  final String password;

  SignUpRequest({
    required this.email,
    required this.userFirstName,
    required this.userLastName,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'userFirstName': userFirstName,
      'userLastName': userLastName,
      'password': password,
    };
  }
}