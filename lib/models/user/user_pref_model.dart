class UserPreferencesModel {
  final String id;
  final String email;
  final String firstName;
  final String lastName;
  final bool isSubscriber;
  final bool hasActiveTrial;

  UserPreferencesModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.isSubscriber = false,
    this.hasActiveTrial = false
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'isSubscriber': isSubscriber,
      'hasActiveTrial':hasActiveTrial
    };
  }

  factory UserPreferencesModel.fromJson(Map<String, dynamic> json) {
    return UserPreferencesModel(
      id: json['id'],
      email: json['email'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      isSubscriber: json['isSubscriber'] ?? false,
      hasActiveTrial: json['hasActiveTrial'] ?? false
    );
  }
}