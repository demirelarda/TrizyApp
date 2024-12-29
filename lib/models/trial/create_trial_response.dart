import 'package:trizy_app/models/trial/trial.dart';

class CreateTrialResponse {
  final bool success;
  final String message;
  final Trial trial;

  CreateTrialResponse({
    required this.success,
    required this.message,
    required this.trial,
  });

  factory CreateTrialResponse.fromJson(Map<String, dynamic> json) {
    return CreateTrialResponse(
      success: json['success'],
      message: json['message'],
      trial: Trial.fromJson(json['trial']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'trial': trial.toJson(),
    };
  }
}