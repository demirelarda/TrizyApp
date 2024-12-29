class User {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final bool emailVerified;
  final bool isSubscriber;
  final bool hasActiveTrial;

  User({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.emailVerified = false,
    this.isSubscriber = false,
    this.hasActiveTrial = false
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      email: json['email'],
      firstName: json['userFirstName'],
      lastName: json['userLastName'],
      emailVerified: json['emailVerified'] ?? false,
      isSubscriber: json['isSubscriber'] ?? false,
      hasActiveTrial: json['hasActiveTrial'] ?? false
    );
  }
}